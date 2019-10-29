
create procedure dbo.UpdateLoanDetail
(
	@LoanDetailID	int,
	@LoanCat		int, 
	@NoteDate		date, 
	@MaturityDate	date, 
	@IntRate		float, 
	@Compound		int, 
	@Frequency		int, 
	@PaymentType	int, 
	@WatchDate		date,
	@RowIsActive	bit
) as
begin transaction

	begin try

	update LoanDetail set LoanCat = @LoanCat, NoteDate = @NoteDate, MaturityDate = @MaturityDate,
		IntRate = @IntRate, Compound = @Compound, Frequency = @Frequency, PaymentType = @PaymentType, WatchDate = @WatchDate,
		RowIsActive = @RowIsActive
	from LoanDetail
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