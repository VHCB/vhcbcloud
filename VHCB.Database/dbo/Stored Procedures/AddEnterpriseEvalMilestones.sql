
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