
create procedure dbo.GetEnterpriseEvalMilestonesById
(
	@EnterpriseEvalID	int
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesById 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, 
			convert(varchar(10), LoanReq) LoanReq, convert(varchar(10), LoanRec) LoanRec, LoanPend, 
			convert(varchar(10), GrantReq) GrantReq, convert(varchar(10), GrantRec) GrantRec, GrantPend,
			convert(varchar(10), OtherReq) OtherReq, convert(varchar(10), OtherRec) OtherRec, OtherPend, 
			SharedOutcome, QuoteUse, QuoteName, RowIsActive 
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