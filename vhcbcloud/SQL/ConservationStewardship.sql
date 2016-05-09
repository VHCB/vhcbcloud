use VHCBSandbox 
go

/*
truncate table ConserveMajorAmend
truncate table ConserveMinorAmend
truncate table ConserveViolations
truncate table ConserveApproval
truncate table ConservePlan

select * from conserve
select * from ConserveMajorAmend
select * from ConserveMinorAmend
select * from ConserveViolations
select * from ConserveApproval
select * from ConservePlan
select * from ConserveEvent
*/

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetMajorAmendmentsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetMajorAmendmentsList 
go

create procedure GetMajorAmendmentsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetMajorAmendmentsList 1, 1
begin
	select  c.ConserveID, a.ConserveMajAmendID, a.LkConsMajAmend, lv.Description as amendment, 
		a.ReqDate, a.LkDisp, lv1.Description disposition, a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveMajorAmend a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkConsMajAmend
	left join LookupValues lv1(nolock) on lv1.TypeID = a.LkDisp
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationMajorAmend]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationMajorAmend
go

create procedure dbo.AddConservationMajorAmend
(
	@ProjectId		int,
	@LkConsMajAmend int,
	@ReqDate		datetime,
	@LkDisp			int,
	@DispDate		datetime,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConserveMajorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMajAmend = @LkConsMajAmend
    )
	begin
		insert into ConserveMajorAmend(ConserveID, LkConsMajAmend, ReqDate, LkDisp, DispDate, DateModified)
		values(@ConserveID, @LkConsMajAmend, @ReqDate, @LkDisp, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveMajorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMajAmend = @LkConsMajAmend 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationMajorAmend]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationMajorAmend
go

create procedure dbo.UpdateConservationMajorAmend
(
	@ConserveMajAmendID	int,
	@ReqDate			datetime,
	@LkDisp				int,
	@DispDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveMajorAmend set  ReqDate= @ReqDate, LkDisp = @LkDisp, DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveMajorAmend 
	where ConserveMajAmendID = @ConserveMajAmendID

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

/* Minor Amendments */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetMinorAmendmentsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetMinorAmendmentsList 
go

create procedure GetMinorAmendmentsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetMinorAmendmentsList 1, 1
begin 
	select  c.ConserveID, a.ConserveMinAmendID, a.LkConsMinAmend, lv.Description as amendment, 
		a.ReqDate, a.LkDisp, lv1.Description disposition, a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveMinorAmend a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkConsMinAmend
	left join LookupValues lv1(nolock) on lv1.TypeID = a.LkDisp
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservationMinorAmend]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservationMinorAmend
go

create procedure dbo.AddConservationMinorAmend
(
	@ProjectId		int,
	@DispDate		datetime,
	@LkConsMinAmend int,
	@ReqDate		datetime,
	@LkDisp			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConserveMinorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMinAmend = @LkConsMinAmend
    )
	begin
		insert into ConserveMinorAmend(ConserveID, LkConsMinAmend, ReqDate, LkDisp, DispDate, DateModified)
		values(@ConserveID, @LkConsMinAmend, @ReqDate, @LkDisp, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveMinorAmend(nolock)
		where ConserveID = @ConserveID 
			and LkConsMinAmend = @LkConsMinAmend 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservationMinorAmend]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservationMinorAmend
go

create procedure dbo.UpdateConservationMinorAmend
(
	@ConserveMinAmendID	int,
	@ReqDate			datetime,
	@LkDisp				int,
	@DispDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveMinorAmend set  ReqDate= @ReqDate, LkDisp = @LkDisp, DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveMinorAmend 
	where ConserveMinAmendID = @ConserveMinAmendID

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

/* Violations */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveViolationsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveViolationsList 
go

create procedure GetConserveViolationsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConserveViolationsList 1, 1
begin 
	select  c.ConserveID, a.ConserveViolationsID, a.LkConsViol, lv.Description as violation, 
		a.ReqDate, a.LkDisp, lv1.Description disposition, a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveViolations a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkConsViol
	left join LookupValues lv1(nolock) on lv1.TypeID = a.LkDisp
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveViolations]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveViolations
go

create procedure dbo.AddConserveViolations
(
	@ProjectId		int,
	@DispDate		datetime,
	@LkConsViol		int,
	@ReqDate		datetime,
	@LkDisp			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConserveViolations(nolock)
		where ConserveID = @ConserveID 
			and LkConsViol = @LkConsViol
    )
	begin
		insert into ConserveViolations(ConserveID, LkConsViol, ReqDate, LkDisp, DispDate, DateModified)
		values(@ConserveID, @LkConsViol, @ReqDate, @LkDisp, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveViolations(nolock)
		where ConserveID = @ConserveID 
			and LkConsViol = @LkConsViol 
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


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveViolations]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveViolations
go

create procedure dbo.UpdateConserveViolations
(
	@ConserveViolationsID	int,
	@ReqDate				datetime,
	@LkDisp					int,
	@DispDate				datetime,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ConserveViolations set  ReqDate= @ReqDate, LkDisp = @LkDisp, DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveViolations 
	where ConserveViolationsID = @ConserveViolationsID

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

/* Approvals */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveApprovalsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveApprovalsList 
go

create procedure GetConserveApprovalsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConserveApprovalsList 1, 1
begin 
	select  c.ConserveID, a.ConserveApprovalID, a.LKApproval, lv.Description as approval, 
		a.ReqDate, a.LkDisp, lv1.Description disposition, a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveApproval a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LKApproval
	left join LookupValues lv1(nolock) on lv1.TypeID = a.LkDisp
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveApprovals]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveApprovals
go

create procedure dbo.AddConserveApprovals
(
	@ProjectId		int,
	@DispDate		datetime,
	@LKApproval		int,
	@ReqDate		datetime,
	@LkDisp			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConserveApproval(nolock)
		where ConserveID = @ConserveID 
			and LKApproval = @LKApproval
    )
	begin
		insert into ConserveApproval(ConserveID, LKApproval, ReqDate, LkDisp, DispDate, DateModified)
		values(@ConserveID, @LKApproval, @ReqDate, @LkDisp, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveApproval(nolock)
		where ConserveID = @ConserveID 
			and LKApproval = @LKApproval
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


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveApprovals]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveApprovals
go

create procedure dbo.UpdateConserveApprovals
(
	@ConserveApprovalID		int,
	@ReqDate				datetime,
	@LkDisp					int,
	@DispDate				datetime,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ConserveApproval set  ReqDate= @ReqDate, LkDisp = @LkDisp, DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveApproval 
	where ConserveApprovalID = @ConserveApprovalID

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

/* Management Plans */ 

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConservePlansList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConservePlansList 
go

create procedure GetConservePlansList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConservePlansList 1, 1 
begin 
	select  c.ConserveID, a.ConservePlanID, a.LKManagePlan, lv.Description as MangePlan, 
		a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConservePlan a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LKManagePlan
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConservePlans]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConservePlans
go

create procedure dbo.AddConservePlans
(
	@ProjectId		int,
	@DispDate		datetime,
	@LKManagePlan		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConservePlan(nolock)
		where ConserveID = @ConserveID 
			and LKManagePlan = @LKManagePlan
    )
	begin
		insert into ConservePlan(ConserveID, LKManagePlan, DispDate, DateModified)
		values(@ConserveID, @LKManagePlan, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConservePlan(nolock)
		where ConserveID = @ConserveID 
			and LKManagePlan = @LKManagePlan
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConservePlans]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConservePlans
go

create procedure dbo.UpdateConservePlans
(
	@ConservePlanID		int,
	@DispDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConservePlan set  DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConservePlan 
	where ConservePlanID = @ConservePlanID

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

/* Events */ 

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetConserveEventList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetConserveEventList 
go

create procedure GetConserveEventList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConserveEventList 1, 1 
begin 
	select  c.ConserveID, a.ConserveEventID, a.LKEvent, lv.Description as EventName, 
		a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveEvent a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LKEvent
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddConserveEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].AddConserveEvent
go

create procedure dbo.AddConserveEvent
(
	@ProjectId		int,
	@DispDate		datetime,
	@LKEvent		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	declare @ConserveID int
	set @isDuplicate = 1
	set @isActive = 1

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
	
	if not exists
    (
		select 1
		from ConserveEvent(nolock)
		where ConserveID = @ConserveID 
			and LKEvent = @LKEvent
    )
	begin
		insert into ConserveEvent(ConserveID, LKEvent, DispDate, DateModified)
		values(@ConserveID, @LKEvent, @DispDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveEvent(nolock)
		where ConserveID = @ConserveID 
			and LKEvent = @LKEvent
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateConserveEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateConserveEvent
go

create procedure dbo.UpdateConserveEvent
(
	@ConserveEventID		int,
	@DispDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveEvent set  DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveEvent 
	where ConserveEventID = @ConserveEventID

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