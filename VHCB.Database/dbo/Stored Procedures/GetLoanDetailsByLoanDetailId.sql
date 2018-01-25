
create procedure dbo.GetLoanDetailsByLoanDetailId
(
	@LoanDetailID		int
) as
--GetLoanDetailsByLoanDetailId 6583
begin transaction

	begin try

	select ld.LoanDetailID, ld.LoanID, ld.LoanCat, ld.NoteDate, ld.MaturityDate, ld.IntRate, ld.Compound, ld.Frequency, 
		ld.PaymentType, ld.WatchDate, ld.RowIsActive
	from LoanDetail ld
	where LoanDetailID = @LoanDetailID
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