
create procedure dbo.UpdateEnterpriseEvalMilestones
(
	@EnterpriseEvalID int,
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
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEvalMilestones set Milestone = @Milestone, MSDate = @MSDate, Comment = @Comment, LeadPlanAdvisorExp = @LeadPlanAdvisorExp, PlanProcess = @PlanProcess, 
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