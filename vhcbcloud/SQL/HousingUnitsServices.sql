use VHCBSandbox 
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingDetailsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingDetailsById
go

create procedure GetHousingDetailsById
(
	@ProjectID		int
)  
as
--exec GetHousingDetailsById 6588
begin
	select h.HousingID, h.LkHouseCat, lv.Description as HouseCat, h.Hsqft, h.TotalUnits, h.Previous, h.NewUnits, h.RelCovenant, 
		h.ResRelease, h.AdaptReuse, h.NewConst, h.Rehab, h.RowIsActive
	from Housing h(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = h.LkHouseCat
	where h.ProjectID = @ProjectID 
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[SubmitHousingUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].SubmitHousingUnits 
go

create procedure SubmitHousingUnits
(
	@HousingID		int,
	@LkHouseCat		int,
	@TotalUnits		int,
	@Hsqft			int,
	@Previous		int,
	@NewUnits		int,
	@RelCovenant	int,
	@ResRelease		Date
) as
begin transaction

	begin try

	update Housing set LkHouseCat = @LkHouseCat, TotalUnits = @TotalUnits, Hsqft = @Hsqft, 
	Previous = @Previous, NewUnits = @NewUnits, RelCovenant = @RelCovenant, ResRelease = @ResRelease
	
	from Housing(nolock) 
	where HousingID = @HousingID

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


/* SubType */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSubTypeList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSubTypeList 
go

create procedure GetHousingSubTypeList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSubTypeList 1, 0
begin
	select  hs.HousingTypeID, hs.LkHouseType, lv.description as HouseType, hs.Units, hs.RowIsActive
	from HousingSubType hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseType
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSubType]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSubType
go

create procedure dbo.AddHousingSubType
(
	@HousingID		int,
	@LkHouseType	int,
	@Units			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from HousingSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
    )
	begin
		insert into HousingSubType(HousingID, LkHouseType, Units, DateModified)
		values(@HousingID, @LkHouseType, @Units, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HousingSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingSubType]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingSubType
go

create procedure dbo.UpdateHousingSubType
(
	@HousingTypeID		int,
	@Units				int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update HousingSubType set  Units = @Units, RowIsActive = @RowIsActive, DateModified = getdate()
	from HousingSubType
	where HousingTypeID = @HousingTypeID

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

  /* ProjectHouseSingleCount*/

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHouseSingleCountList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHouseSingleCountList 
go

create procedure GetHouseSingleCountList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHouseSingleCountList 1, 0
begin
	select  hs.ProjectSingleCountID, hs.LkUnitChar, lv.description as Characteristic, hs.Numunits, hs.RowIsActive
	from ProjectHouseSingleCount hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkUnitChar
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseSingleCount]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseSingleCount
go

create procedure dbo.AddHouseSingleCount
(
	@HousingID		int,
	@LkUnitChar		int,
	@Numunits		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ProjectHouseSingleCount(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
    )
	begin
		insert into ProjectHouseSingleCount(HousingID, LkUnitChar, Numunits, DateModified)
		values(@HousingID, @LkUnitChar, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSingleCount(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseSingleCount]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseSingleCount
go

create procedure dbo.UpdateHouseSingleCount
(
	@ProjectSingleCountID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseSingleCount set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSingleCount
	where ProjectSingleCountID = @ProjectSingleCountID

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

 /* ProjectHouseMultiCount*/
 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHouseMultiCountList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHouseMultiCountList 
go

create procedure GetHouseMultiCountList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHouseMultiCountList 1, 0
begin
	select  hs.ProjectMultiCountID, hs.LkUnitChar, lv.description as Characteristic, hs.Numunits, hs.RowIsActive
	from ProjectHouseMultiCount hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkUnitChar
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHouseMultiCount]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHouseMultiCount
go

create procedure dbo.AddHouseMultiCount
(
	@HousingID		int,
	@LkUnitChar		int,
	@Numunits		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ProjectHouseMultiCount(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
    )
	begin
		insert into ProjectHouseMultiCount(HousingID, LkUnitChar, Numunits, DateModified)
		values(@HousingID, @LkUnitChar, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseMultiCount(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHouseMultiCount]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHouseMultiCount
go

create procedure dbo.UpdateHouseMultiCount
(
	@ProjectMultiCountID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseMultiCount set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseMultiCount
	where ProjectMultiCountID = @ProjectMultiCountID

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

/* ProjectSuppServ*/
 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingSuppServList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingSuppServList 
go

create procedure GetHousingSuppServList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSuppServList 1, 0
begin
	select  hs.ProjectSuppServID, hs.LkSuppServ, lv.description as Service, hs.Numunits, hs.RowIsActive
	from ProjectSuppServ hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkSuppServ
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingSuppServ]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingSuppServ
go

create procedure dbo.AddHousingSuppServ
(
	@HousingID		int,
	@LkSuppServ		int,
	@Numunits		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ProjectSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
    )
	begin
		insert into ProjectSuppServ(HousingID, LkSuppServ, Numunits, DateModified)
		values(@HousingID, @LkSuppServ, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingSuppServ]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingSuppServ
go

create procedure dbo.UpdateHousingSuppServ
(
	@ProjectSuppServID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectSuppServ set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectSuppServ
	where ProjectSuppServID = @ProjectSuppServID

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

/* ProjectVHCBAffordUnits */

 if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHousingVHCBAffordUnitsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHousingVHCBAffordUnitsList 
go

create procedure GetHousingVHCBAffordUnitsList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingVHCBAffordUnitsList 1, 0
begin
	select  hs.ProjectVHCBAffordUnitsID, hs.LkAffordunits, lv.description as VHCB, hs.Numunits, hs.RowIsActive
	from ProjectVHCBAffordUnits hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHousingVHCBAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHousingVHCBAffordUnits
go

create procedure dbo.AddHousingVHCBAffordUnits
(
	@HousingID		int,
	@LkAffordunits	int,
	@Numunits		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ProjectVHCBAffordUnits(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
    )
	begin
		insert into ProjectVHCBAffordUnits(HousingID, LkAffordunits, Numunits, DateModified)
		values(@HousingID, @LkAffordunits, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectVHCBAffordUnits(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHousingVHCBAffordUnits]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHousingVHCBAffordUnits
go

create procedure dbo.UpdateHousingVHCBAffordUnits
(
	@ProjectVHCBAffordUnitsID	int,
	@Numunits					int,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectVHCBAffordUnits set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectVHCBAffordUnits
	where ProjectVHCBAffordUnitsID = @ProjectVHCBAffordUnitsID

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

