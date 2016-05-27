use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConsolidatedPlanPrioritiesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConsolidatedPlanPrioritiesList
go

create procedure GetConsolidatedPlanPrioritiesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConsolidatedPlanPrioritiesList 1, 1
begin
	select  pcp.ProjectConPlanPrioritiesID, pcp.LkConplanPriorities, lv.description as Priorities, pcp.RowIsActive
	from ProjectConPlanPriorities pcp(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pcp.LkConplanPriorities
	where pcp.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pcp.RowIsActive = @IsActiveOnly)
		order by pcp.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConsolidatedPlanPriorities]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConsolidatedPlanPriorities
go

create procedure dbo.AddConsolidatedPlanPriorities
(
	@ProjectID				int,
	@LkConplanPriorities	int,
	@UserID					int,
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
		from ProjectConPlanPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkConplanPriorities = @LkConplanPriorities
    )
	begin
		insert into ProjectConPlanPriorities(ProjectID, LkConplanPriorities, UserID, DateModified)
		values(@ProjectID, @LkConplanPriorities, @UserID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectConPlanPriorities(nolock)
		where ProjectID = @ProjectID
			and LkConplanPriorities = @LkConplanPriorities
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConsolidatedPlanPriorities]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConsolidatedPlanPriorities
go

create procedure dbo.UpdateConsolidatedPlanPriorities
(
	@ProjectConPlanPrioritiesID	int,
	@UserID						int,
	@RowIsActive				bit
) as
begin transaction

	begin try
	
	update ProjectConPlanPriorities set RowIsActive = @RowIsActive, UserID = @UserID, DateModified = getdate()
	from ProjectConPlanPriorities 
	where ProjectConPlanPrioritiesID = @ProjectConPlanPrioritiesID

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

/* ProjectInteragency */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectInteragencyList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectInteragencyList
go

create procedure GetProjectInteragencyList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectInteragencyList 1, 1
begin
	select  pin.ProjectInteragencyID, pin.LkInteragency, lv.description as Priorities, pin.RowIsActive   
	from ProjectInteragency pin(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pin.LkInteragency
	where pin.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pin.RowIsActive = @IsActiveOnly)
		order by pin.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectInteragency]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectInteragency
go

create procedure dbo.AddProjectInteragency
(
	@ProjectID		int,
	@LkInteragency	int,
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
		from ProjectInteragency(nolock)
		where ProjectID = @ProjectID 
			and LkInteragency = @LkInteragency
    )
	begin
		insert into ProjectInteragency(ProjectID, LkInteragency, Numunits, DateModified)
		values(@ProjectID, @LkInteragency, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectInteragency(nolock)
		where ProjectID = @ProjectID 
			and LkInteragency = @LkInteragency
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectInteragency]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectInteragency
go

create procedure dbo.UpdateProjectInteragency
(
	@ProjectInteragencyID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ProjectInteragency set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectInteragency 
	where ProjectInteragencyID = @ProjectInteragencyID

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

/* ProjectVHCBPriorities */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectVHCBPrioritiesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectVHCBPrioritiesList
go

create procedure GetProjectVHCBPrioritiesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectVHCBPrioritiesList 1, 1
begin
	select  pvhcb.ProjectVHCBPrioritiesID, pvhcb.LkVHCBPriorities, lv.Description as Priorities, pvhcb.RowIsActive
	from ProjectVHCBPriorities pvhcb(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pvhcb.LkVHCBPriorities
	where pvhcb.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pvhcb.RowIsActive = @IsActiveOnly)
		order by pvhcb.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectVHCBPriorities]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectVHCBPriorities
go

create procedure dbo.AddProjectVHCBPriorities
( 
	@ProjectID			int,
	@LkVHCBPriorities	int,
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
		from ProjectVHCBPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkVHCBPriorities = @LkVHCBPriorities
    )
	begin
		insert into ProjectVHCBPriorities(ProjectID, LkVHCBPriorities, DateModified)
		values(@ProjectID, @LkVHCBPriorities, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectVHCBPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkVHCBPriorities = @LkVHCBPriorities
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectVHCBPriorities]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectVHCBPriorities
go

create procedure dbo.UpdateProjectVHCBPriorities
(
	@ProjectVHCBPrioritiesID	int,
	@RowIsActive				bit
) as
begin transaction

	begin try
	
	update ProjectVHCBPriorities set RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectVHCBPriorities 
	where ProjectVHCBPrioritiesID = @ProjectVHCBPrioritiesID

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

/* ProjectOtherOutcomes */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectOtherOutcomesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectOtherOutcomesList
go

create procedure GetProjectOtherOutcomesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectOtherOutcomesList 1, 1
begin
	select  po.ProjectOtherOutcomesID, po.LkOtherOutcomes, lv.Description as Priorities,  po.Numunits, po.RowIsActive
	from ProjectOtherOutcomes po(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = po.LkOtherOutcomes
	where po.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or po.RowIsActive = @IsActiveOnly)
		order by po.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectOtherOutcomes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectOtherOutcomes
go

create procedure dbo.AddProjectOtherOutcomes
(
	@ProjectID			int,
	@LkOtherOutcomes	int,
	@Numunits			int,
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
		from ProjectOtherOutcomes(nolock)
		where ProjectID = @ProjectID 
			and LkOtherOutcomes = @LkOtherOutcomes
    )
	begin
		insert into ProjectOtherOutcomes(ProjectID, LkOtherOutcomes, Numunits, DateModified)
		values(@ProjectID, @LkOtherOutcomes, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectOtherOutcomes(nolock)
		where ProjectID = @ProjectID 
			and LkOtherOutcomes = @LkOtherOutcomes
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectOtherOutcomes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectOtherOutcomes
go

create procedure dbo.UpdateProjectOtherOutcomes
(
	@ProjectOtherOutcomesID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ProjectOtherOutcomes set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectOtherOutcomes 
	where ProjectOtherOutcomesID = @ProjectOtherOutcomesID

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