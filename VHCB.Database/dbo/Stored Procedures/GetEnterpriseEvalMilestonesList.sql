
create procedure dbo.GetEnterpriseEvalMilestonesList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesList 6657, 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, lv.Description as MilestoneDesc,
			MSDate, substring(Comment, 0, 25) ShortComment, Comment,
			LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName, 
			ep.RowIsActive
		from EnterpriseEvalMilestones ep(nolock)
		left join LookupValues lv(nolock) on typeid = ep.Milestone
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