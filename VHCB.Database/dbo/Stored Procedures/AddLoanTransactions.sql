
create procedure dbo.AddLoanTransactions
(
	@LoanID			int, 
	@TransType		int, 
	@TransDate		datetime, 
	@IntRate		float = null, 
	@Compound		int = null,
	@Freq			int = null,
	@PayType		int = null,
	@MatDate		datetime = null,
	@StartDate		datetime = null,
	@Amount			money = null,
	@StopDate		datetime = null,
	@Principal		money = null,
	@Interest		money = null,
	@Description	nvarchar(150) = null, 
	@TransferTo		int = null,
	@ConvertFrom	int = null
) as
begin transaction

	begin try

		insert into LoanTransactions(LoanID, TransType, TransDate, IntRate, Compound, Freq, PayType, MatDate, StartDate, 
			Amount, StopDate, Principal, Interest, Description, TransferTo, ConvertFrom)
		values(@LoanID, @TransType, @TransDate, @IntRate, @Compound, @Freq, @PayType, @MatDate, @StartDate,
		 @Amount, @StopDate, @Principal, @Interest, @Description, @TransferTo, @ConvertFrom)

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