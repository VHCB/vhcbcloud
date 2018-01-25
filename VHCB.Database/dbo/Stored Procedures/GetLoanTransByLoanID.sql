
create procedure dbo.GetLoanTransByLoanID
(
	@LoanTransID			int
) as
--GetLoanTransByLoanID 1, 1
begin transaction

	begin try
	
	select LoanID, TransType, TransDate, IntRate, Compound, Freq, PayType, MatDate, StartDate, 
		Amount, StopDate, Principal, Interest, Description, TransferTo, ConvertFrom, RowIsActive
	from LoanTransactions lm(nolock) 
	where lm.LoanTransID = @LoanTransID
	

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