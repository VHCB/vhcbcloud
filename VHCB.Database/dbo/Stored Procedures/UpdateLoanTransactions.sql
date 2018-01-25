
create procedure dbo.UpdateLoanTransactions
(
	@LoanTransID	int, 
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
	@ConvertFrom	int = null,
	@RowIsActive	bit
) as
begin transaction

	begin try

		update LoanTransactions set TransType = @TransType, TransDate = @TransDate, IntRate = @IntRate, Compound = @Compound, Freq = @Freq, 
		PayType = @PayType, MatDate = @MatDate, StartDate = @StartDate, Amount = @Amount, StopDate = @StopDate, Principal = @Principal, Interest = @Interest, 
		Description = @Description, TransferTo = @TransferTo, ConvertFrom = @ConvertFrom, RowIsActive = @RowIsActive
		where LoanTransID = @LoanTransID

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