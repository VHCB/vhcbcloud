use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetLatestBudgetPeriod]') and type in (N'P', N'PC'))
drop procedure [dbo].GetLatestBudgetPeriod 
go

create procedure GetLatestBudgetPeriod
(
	@ProjectID		int,
	@LKBudgetPeriod	int output
)  
as
--exec GetLatestBudgetPeriod 66251, null
begin
	--select  @LKBudgetPeriod = isnull(max(csu.LKBudgetPeriod), 0)
	select  @LKBudgetPeriod = isnull(csu.LKBudgetPeriod, 0)
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	where c.ProjectID = @ProjectID  and csu.MostCurrent = 1
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveSourcesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveSourcesList 
go

create procedure GetConserveSourcesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveSourcesList 6622,26084, 0
begin
	select  cs.ConserveSourcesID, c.ConserveID, cs.LkConSource, cs.Total, lv.description SourceName, cs.RowIsActive
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveSources cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConSource
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or cs.RowIsActive = @IsActiveOnly)
		order by cs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationSource]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationSource
go

create procedure dbo.AddConservationSource
(
	@ProjectId		int,
	@LKBudgetPeriod int,
	@LkConSource	int,
	@Total			decimal(18,2),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID)
		values(@ProjectId)

		set @ConserveID = @@IDENTITY
	end
	else
	begin
		select @ConserveID = ConserveID 
		from Conserve(nolock) 
		where ProjectID = @ProjectId
	end

	declare @ConserveSUID int

	if not exists
    (
		select 1
		from ConserveSU(nolock)
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		update ConserveSU set MostCurrent = 0 where ConserveID = @ConserveID and MostCurrent = 1

		insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified, MostCurrent)
		values(@ConserveID, @LKBudgetPeriod, getdate(), 1)

		set @ConserveSUID = @@IDENTITY
	end
	else
	begin
		select @ConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ConserveSources(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConSource = @LkConSource
    )
	begin
		insert into ConserveSources(ConserveSUID, LkConSource, Total, DateModified)
		values(@ConserveSUID, @LkConSource, @Total, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveSources(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConSource = @LkConSource 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationSource]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationSource
go

create procedure dbo.UpdateConservationSource
(
	@ConserveSourcesID	int,
	--@LkConSource		int,
	@Total				decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveSources set --LkConSource = @LkConSource, 
		Total = @Total, RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveSources where ConserveSourcesID = @ConserveSourcesID

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
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveUsesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveUsesList 
go

create procedure GetConserveUsesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveUsesList 1,26083
begin
	select  cs.ConserveUsesID, c.ConserveID, 
	cs.LkConUseVHCB, cs.VHCBTotal, lv.description VHCBUseName, 
	cs.LkConUseOther, cs.OtherTotal, lv1.Description OtherUseName,
	cs.VHCBTotal + cs.OtherTotal 'Total',
	cs.RowIsActive
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveUses cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConUseVHCB
	join LookupValues lv1(nolock) on lv1.TypeId = cs.LkConUseOther
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or cs.RowIsActive = @IsActiveOnly)
		order by cs.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationUse]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationUse
go

create procedure dbo.AddConservationUse
(
	@ProjectId		int,
	@LKBudgetPeriod int,
	@LkConUseVHCB	int,
	@VHCBTotal		decimal(18, 2),
	@LkConUseOther	int,
	@OtherTotal		decimal(18, 2),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID)
		values(@ProjectId)

		set @ConserveID = @@IDENTITY
	end
	else
	begin
		select @ConserveID = ConserveID 
		from Conserve(nolock) 
		where ProjectID = @ProjectId
	end

	declare @ConserveSUID int

	if not exists
    (
		select 1
		from ConserveSU(nolock)
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin
		update ConserveSU set MostCurrent = 0 where ConserveID = @ConserveID and MostCurrent = 1

		insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified, MostCurrent)
		values(@ConserveID, @LKBudgetPeriod, getdate(), 1)

		set @ConserveSUID = @@IDENTITY
	end
	else
	begin
		select @ConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ConserveUses(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConUseVHCB = @LkConUseVHCB
    )
	begin
		insert into ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal)
		values(@ConserveSUID, @LkConUseVHCB, @VHCBTotal, @LkConUseOther, @OtherTotal)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveUses(nolock)
		where ConserveSUID = @ConserveSUID 
			and LkConUseVHCB = @LkConUseVHCB 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationUse]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationUse
go

create procedure dbo.UpdateConservationUse
(
	@ConserveUsesID	int,
	@VHCBTotal			decimal(18, 2),
	@OtherTotal			decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveUses set --LkConSource = @LkConSource, 
		VHCBTotal = @VHCBTotal, OtherTotal = @OtherTotal, RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveUses where ConserveUsesID = @ConserveUsesID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservationUses]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservationUses
go

create procedure dbo.GetConservationUses
(
	@UsesDescription varchar(10)
) as
begin transaction
-- exec GetConservationUses 'VHCB'
	begin try

	if(@UsesDescription = 'vhcb')
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 99 
			and description like 'vhcb%'
	end
	else
	begin

		select TypeId, Description 
		from lookupvalues 
		where lookuptype = 99 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[conservationSourcesUsesCount_v]') and type in (N'V'))
drop view conservationSourcesUsesCount_v
go

Create view conservationSourcesUsesCount_v as
	select c.ProjectID, c.ConserveID, csu.ConserveSUID, csu.LKBudgetPeriod, cs.SourceCount, cu.UsesCount
	from Conserve c(nolock)
	join conserveSU csu(nolock) on c.ConserveID = csu.ConserveID
	left join (select ConserveSUID, count(*) SourceCount from conserveSources(nolock) where RowIsActive = 1 group by  ConserveSUID )as cs on csu.ConserveSUID = cs.ConserveSUID
	left join (select ConserveSUID, count(*) UsesCount from conserveUses(nolock) where RowIsActive = 1 group by  ConserveSUID )as cu on csu.ConserveSUID = cu.ConserveSUID
	--where c.ProjectID = 6622
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[PopulateImportBudgetPeriodDropDown]') and type in (N'P', N'PC'))
drop procedure [dbo].PopulateImportBudgetPeriodDropDown
go

create procedure PopulateImportBudgetPeriodDropDown
(
	@ProjectID		int,
	@LKBudgetPeriod int
)  
as
begin
	--exec PopulateImportBudgetPeriodDropDown 6622, 26084
	if exists
    (
		select 1 
		from conservationSourcesUsesCount_v v(nolock)
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
		from conservationSourcesUsesCount_v v(nolock)
		join LookupValues lv(nolock) on lv.TypeId = v.LKBudgetPeriod
		where ProjectID = @ProjectID 
			and LKBudgetPeriod != @LKBudgetPeriod
			and (isnull(v.SourceCount, 0) >0 or isnull(v.UsesCount, 0) > 0) 
		order by LKBudgetPeriod
	end
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[ImportBudgetPeriodData]') and type in (N'P', N'PC'))
drop procedure [dbo].ImportBudgetPeriodData
go

create procedure ImportBudgetPeriodData
(
	@ProjectID				int,
	@ImportLKBudgetPeriod	int,
	@LKBudgetPeriod			int
)  
as
/*
exec ImportBudgetPeriodData 6586,26084, 26085


select * from conserve
select * from ConserveSU where conserveid = 3
select * from ConserveSources where ConserveSUId = 7
select * from ConserveUses where ConserveSUId = 7
*/
begin
		declare @ConserveID	int
		declare @ConserveSUID int
		declare @ImportFromConserveSUID int

		if not exists
		(
			select 1 
			from Conserve(nolock) 
			where ProjectID = @ProjectID
		)
		begin
			RAISERROR ('Invalid Import1, No Project exist', 16, 1)
			return 1
		end
		else
		begin
			select @ConserveID = ConserveID 
			from Conserve(nolock) 
			where ProjectID = @ProjectID
		end 

		if not exists
		(
			select 1
			from ConserveSU(nolock)
			where ConserveID = @ConserveID 
				and LKBudgetPeriod = @LKBudgetPeriod
		)
		begin
			update ConserveSU set MostCurrent = 0 where ConserveID = @ConserveID and MostCurrent = 1

			insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified, MostCurrent)
			values(@ConserveID, @LKBudgetPeriod, getdate(), 1)

			set @ConserveSUID = @@IDENTITY
		end
		else
		begin
			select @ConserveSUID = ConserveSUID
			from ConserveSU(nolock)
			where ConserveID = @ConserveID 
				and LKBudgetPeriod = @LKBudgetPeriod
		end

		select @ImportFromConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @ImportLKBudgetPeriod

		insert into ConserveSources(ConserveSUID, LkConSource, Total, DateModified)
		select @ConserveSUID, LkConSource, Total, getdate()
		from ConserveSources (nolock)
		where RowIsActive = 1 and ConserveSUID = @ImportFromConserveSUID

		insert into ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal, DateModified)
		select @ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal, getdate()
		from ConserveUses (nolock)
		where RowIsActive = 1 and ConserveSUID = @ImportFromConserveSUID
end
go