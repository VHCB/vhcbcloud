use vhcbsandbox
go

/* EnterpriseEvalMilestones */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEvalMilestonesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEvalMilestonesList
go

create procedure dbo.GetEnterpriseEvalMilestonesList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesList 5594, 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName, 
		RowIsActive
		from EnterpriseEvalMilestones ep(nolock)
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseEvalID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseEvalMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseEvalMilestones
go

create procedure dbo.AddEnterpriseEvalMilestones
(
	@ProjectID		int,
	@Milestone		int, 
	@MSDate			DateTime, 
	@Comment		nvarchar(max), 
	@LeadPlanAdvisorExp nvarchar(max), 
	@PlanProcess	bit, 
	@LoanReq	money, 
	@LoanRec	money, 
	@LoanPend	money,
	@GrantReq	money, 
	@GrantRec	money, 
	@GrantPend	money, 
	@OtherReq	money, 
	@OtherRec	money, 
	@OtherPend	money, 
	@SharedOutcome nvarchar(max), 
	@QuoteUse		int, 
	@QuoteName		nvarchar(25) = null,
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
		from EnterpriseEvalMilestones (nolock)
		where ProjectID = @ProjectID and Milestone = @Milestone
    )
	begin
		insert into EnterpriseEvalMilestones(ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, 
		GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName)
		values(@ProjectID, @Milestone, @MSDate, @Comment, @LeadPlanAdvisorExp, @PlanProcess, @LoanReq, @LoanRec, @LoanPend, 
		@GrantReq, @GrantRec, @GrantPend, @OtherReq, @OtherRec, @OtherPend, @SharedOutcome, @QuoteUse, @QuoteName)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseEvalMilestones (nolock)
		where ProjectID = @ProjectID and Milestone = @Milestone
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseEvalMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseEvalMilestones
go

create procedure dbo.UpdateEnterpriseEvalMilestones
(
	@EnterpriseEvalID int,
	@MSDate			DateTime, 
	@Comment		nvarchar(max), 
	@LeadPlanAdvisorExp nvarchar(max), 
	@PlanProcess	bit, 
	@LoanReq	money, 
	@LoanRec	money, 
	@LoanPend	money,
	@GrantReq	money, 
	@GrantRec	money, 
	@GrantPend	money, 
	@OtherReq	money, 
	@OtherRec	money, 
	@OtherPend	money, 
	@SharedOutcome nvarchar(max), 
	@QuoteUse		int, 
	@QuoteName		nvarchar(25) = null,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEvalMilestones set MSDate = @MSDate, Comment = @Comment, LeadPlanAdvisorExp = @LeadPlanAdvisorExp, PlanProcess = @PlanProcess, 
		LoanReq = @LoanReq, LoanRec = @LoanRec, LoanPend = @LoanPend, 
		GrantReq = @GrantReq, GrantRec = @GrantRec, GrantPend = @GrantPend, OtherReq = @OtherReq, OtherRec = @OtherRec, OtherPend = @OtherPend, 
		SharedOutcome = @SharedOutcome, QuoteUse = @QuoteUse, QuoteName = @QuoteName,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEvalMilestones 
	where EnterpriseEvalID = @EnterpriseEvalID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEvalMilestonesById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEvalMilestonesById
go

create procedure dbo.GetEnterpriseEvalMilestonesById
(
	@EnterpriseEvalID	int
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesById 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, 
			GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName, RowIsActive 
		from EnterpriseEvalMilestones ep(nolock)
		where EnterpriseEvalID = @EnterpriseEvalID
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