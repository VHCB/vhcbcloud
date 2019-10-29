
create procedure dbo.GetLoanMasterListByProject
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
--GetLoanMasterListByProject 6583, 1
begin transaction

	begin try

	select LoanID, ProjectID, Descriptor, TaxCreditPartner, v.AppNameID, v.Applicantname, DetailID, NoteOwner, NoteAmt, 
		lm.FundID, f.name as FundName, ImportDate, lm.RowIsActive
	from LoanMaster lm(nolock) 
	left join Fund f(nolock) on f.fundid = lm.fundid
	left join applicant_v v on v.applicantid = lm.applicantid
	where lm.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or lm.RowIsActive = @IsActiveOnly)
		order by lm.DateModified desc
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