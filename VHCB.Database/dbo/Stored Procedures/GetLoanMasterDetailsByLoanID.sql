
create procedure dbo.GetLoanMasterDetailsByLoanID
(
	@LoanID int
) as
--GetLoanMasterDetailsByLoanID 20
begin transaction

	begin try
	
	select LoanID, ProjectID, Convert(varchar(10), isnull(NoteAmt, 0)) NoteAmt, Descriptor, TaxCreditPartner, ApplicantID, an.Applicantname, DetailID, NoteOwner, FundID, ImportDate, lm.RowIsActive
	from LoanMaster lm(nolock) 
	left join Appname an(nolock) on lm.ApplicantID = an.AppNameID
	where lm.LoanID = @LoanID

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