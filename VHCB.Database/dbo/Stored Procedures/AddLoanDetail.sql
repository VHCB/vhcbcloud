
create procedure dbo.AddLoanDetail
(
	@LoanID			int, 
	@LoanCat		int, 
	@NoteDate		date, 
	@MaturityDate	date, 
	@IntRate		float, 
	@Compound		int, 
	@Frequency		int, 
	@PaymentType	int, 
	@WatchDate		date
) as
begin transaction

	begin try

	insert into LoanDetail(LoanID, LoanCat, NoteDate, MaturityDate, IntRate, Compound, Frequency, PaymentType, WatchDate)
	values(@LoanID, @LoanCat, @NoteDate, @MaturityDate, @IntRate, @Compound, @Frequency, @PaymentType, @WatchDate)

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