use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingID
go 

create procedure GetHousingID
(
	@ProjectID		int,
	@HousingID		int output
) as
begin transaction

	begin try

	if not exists
    (
		select 1
		from Housing(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Housing(ProjectID)
		values(@ProjectId)

		set @HousingID = @@IDENTITY
	end
	else
	begin
		select @HousingID = HousingID 
		from Housing(nolock) 
		where ProjectID = @ProjectId
	end
	select @HousingID
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
        RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLatestHousingBudgetPeriod]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLatestHousingBudgetPeriod 
go

create procedure GetLatestHousingBudgetPeriod
(
	@ProjectID		int,
	@LKBudgetPeriod	int output
)  
as
--exec GetLatestHousingBudgetPeriod 66251, null
begin
	select  @LKBudgetPeriod = isnull(max(hsu.LkBudgetPeriod), 0)
	from Housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID  = hsu.HousingId 
	where h.ProjectID = @ProjectID 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSourcesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSourcesList 
go

create procedure GetHousingSourcesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSourcesList 6622,26084, 0
begin
	select  hs.HouseSourceID, h.HousingID, hs.LkHouseSource, hs.Total, lv.description SourceName, hs.RowIsActive
	from housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	join houseSource hs(nolock) on hsu.HouseSUID = hs.HouseSUID
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseSource
	where h.ProjectID = @ProjectID 
		and hsu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseSource]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseSource
go

create procedure dbo.AddHouseSource
(
	@HousingID		int,
	@LKBudgetPeriod int,
	@LkHouseSource	int,
	@Total			decimal,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @HouseSUID int

	if not exists
    (
		select 1
		from HouseSU(nolock)
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		insert into HouseSU(HousingID, LKBudgetPeriod, DateModified)
		values(@HousingID, @LKBudgetPeriod, getdate())

		set @HouseSUID = @@IDENTITY
	end
	else
	begin
		select @HouseSUID = HouseSUID 
		from HouseSU(nolock) 
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from HouseSource(nolock)
		where HouseSUID = @HouseSUID 
			and LkHouseSource = @LkHouseSource
    )
	begin
		insert into HouseSource(HouseSUID, LkHouseSource, Total, DateModified)
		values(@HouseSUID, @LkHouseSource, @Total, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HouseSource(nolock)
		where HouseSUID = @HouseSUID 
			and LkHouseSource = @LkHouseSource
	end

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
        RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseSource]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseSource
go

create procedure dbo.UpdateHouseSource
(
	@HouseSourceID		int,
	@Total				decimal,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update HouseSource set 
		Total = @Total, RowIsActive = @RowIsActive, DateModified = getdate()
	from HouseSource where HouseSourceID = @HouseSourceID

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

/* Uses */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingUsesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingUsesList 
go

create procedure GetHousingUsesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingUsesList 1,26083
begin
	select  hu.HouseUseID, h.HousingID, 
	hu.LkHouseUseVHCB, hu.VHCBTotal, lv.description VHCBUseName, 
	hu.LKHouseUseOther, hu.OtherTotal, lv1.Description OtherUseName,
	hu.VHCBTotal + hu.OtherTotal 'Total',
	hu.RowIsActive
	from housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	join HouseUse hu(nolock) on hsu.HouseSUID = hu.HouseSUID
	join LookupValues lv(nolock) on lv.TypeId = hu.LkHouseUseVHCB
	join LookupValues lv1(nolock) on lv1.TypeId = hu.LKHouseUseOther
	where h.ProjectID = @ProjectID 
		and hsu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or hu.RowIsActive = @IsActiveOnly)
		order by hu.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseUse]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseUse
go

create procedure dbo.AddHouseUse
(
	@HousingID			int,
	@LKBudgetPeriod		int,
	@LkHouseUseVHCB		int,
	@VHCBTotal			decimal,
	@LKHouseUseOther	int,
	@OtherTotal			decimal,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	declare @HouseSUID int

	if not exists
    (
		select 1
		from HouseSU(nolock)
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		insert into HouseSU(HousingID, LKBudgetPeriod, DateModified)
		values(@HousingID, @LKBudgetPeriod, getdate())

		set @HouseSUID = @@IDENTITY
	end
	else
	begin
		select @HouseSUID = HouseSUID 
		from HouseSU(nolock) 
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from HouseUse(nolock)
		where HouseSUID = @HouseSUID
			and LkHouseUseVHCB = @LkHouseUseVHCB
    )
	begin
		insert into HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal)
		values(@HouseSUID, @LkHouseUseVHCB, @VHCBTotal, @LKHouseUseOther, @OtherTotal)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HouseUse(nolock)
		where HouseSUID = @HouseSUID
			and LkHouseUseVHCB = @LkHouseUseVHCB
	end

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseUse]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseUse
go

create procedure dbo.UpdateHouseUse
(
	@HouseUseID			int,
	@VHCBTotal			decimal,
	@OtherTotal			decimal,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update HouseUse set 
		VHCBTotal = @VHCBTotal, OtherTotal = @OtherTotal, RowIsActive = @RowIsActive, DateModified = getdate()
	from HouseUse where HouseUseID = @HouseUseID

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHouseUses]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHouseUses
go

create procedure dbo.GetHouseUses
(
	@UsesDescription varchar(10)
) as
begin transaction
-- exec GetHouseUses 'VHCB'
	begin try

	if(@UsesDescription = 'vhcb')
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 114 
			and description like 'vhcb%'
	end
	else
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 114 
			and description not like 'vhcb%'

	end
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

/* Import */
--select * from HousingSourcesUsesCount_v
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[HousingSourcesUsesCount_v]') and type in (N'V'))
drop view HousingSourcesUsesCount_v
go

Create view HousingSourcesUsesCount_v as
	select h.ProjectID, h.HousingID, hsu.HouseSUID, hsu.LkBudgetPeriod, hs.SourceCount, hu.UsesCount
	from Housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	left join (select HouseSUID, count(*) SourceCount from HouseSource(nolock) where RowIsActive = 1 group by  HouseSUID )as hs on hsu.HouseSUID = hs.HouseSUID
	left join (select HouseSUID, count(*) UsesCount from HouseUse(nolock) where RowIsActive = 1 group by  HouseSUID )as hu on  hsu.HouseSUID = hu.HouseSUID
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[PopulateHousingImportBudgetPeriodDropDown]') and type in (N'P', N'PC'))
drop procedure [dbo].PopulateHousingImportBudgetPeriodDropDown
go

create procedure PopulateHousingImportBudgetPeriodDropDown
(
	@ProjectID		int,
	@LKBudgetPeriod int
)  
as
begin
	--exec PopulateHousingImportBudgetPeriodDropDown 6622, 26084
	if exists
    (
		select 1 
		from HousingSourcesUsesCount_v v(nolock)
		where ProjectID = @ProjectID 
			and LKBudgetPeriod = @LKBudgetPeriod
			and (isnull(v.SourceCount, 0) >0 or isnull(v.UsesCount, 0) > 0) 
	)
	begin
		select lv.TypeID, lv.Description 
		from  LookupValues lv(nolock)
		where 1 != 1
	end
	else
	begin
		select lv.TypeID, lv.Description 
		from HousingSourcesUsesCount_v v(nolock)
		join LookupValues lv(nolock) on lv.TypeId = v.LKBudgetPeriod
		where ProjectID = @ProjectID 
			and LKBudgetPeriod != @LKBudgetPeriod
			and (isnull(v.SourceCount, 0) >0 or isnull(v.UsesCount, 0) > 0) 
		order by LKBudgetPeriod
	end
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[ImportHousingBudgetPeriodData]') and type in (N'P', N'PC'))
drop procedure [dbo].ImportHousingBudgetPeriodData
go

create procedure ImportHousingBudgetPeriodData
(
	@ProjectID				int,
	@ImportLKBudgetPeriod	int,
	@LKBudgetPeriod			int
)  
as
/*
exec ImportHousingBudgetPeriodData 6586,26084, 26085


select * from conserve
select * from ConserveSU where conserveid = 3
select * from ConserveSources where ConserveSUId = 7
select * from ConserveUses where ConserveSUId = 7
*/
begin
		declare @HousingID	int
		declare @HouseSUID int
		declare @ImportFromHouseSUID int

		if not exists
		(
			select 1 
			from Housing(nolock) 
			where ProjectID = @ProjectID
		)
		begin
			RAISERROR ('Invalid Import1, No Project exist', 16, 1)
			return 1
		end
		else
		begin
			select @HousingID = HousingID 
			from Housing(nolock) 
			where ProjectID = @ProjectID
		end 

		if not exists
		(
			select 1
			from HouseSU(nolock)
			where HousingID = @HousingID 
				and LKBudgetPeriod = @LKBudgetPeriod
		)
		begin
			insert into HouseSU(HousingID, LKBudgetPeriod, DateModified)
			values(@HousingID, @LKBudgetPeriod, getdate())

			set @HouseSUID = @@IDENTITY
		end
		else
		begin
			select @HouseSUID = HouseSUID
			from HouseSU(nolock)
			where HousingID = @HousingID 
				and LKBudgetPeriod = @LKBudgetPeriod
		end

		select @ImportFromHouseSUID = HouseSUID 
		from HouseSU(nolock) 
		where HousingID = @HousingID 
			and LKBudgetPeriod = @ImportLKBudgetPeriod

		insert into HouseSource(HouseSUID, LkHouseSource, Total, DateModified)
		select @HouseSUID, LkHouseSource, Total, getdate()
		from HouseSource (nolock)
		where RowIsActive = 1 and HouseSUID = @ImportFromHouseSUID

		insert into HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal, DateModified)
		select @HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal, getdate()
		from HouseUse (nolock)
		where RowIsActive = 1 and HouseSUID = @ImportFromHouseSUID
end
go