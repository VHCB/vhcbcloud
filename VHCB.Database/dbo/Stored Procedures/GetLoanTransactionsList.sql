
create procedure dbo.GetLoanTransactionsList
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanTransactionsList 11, 1
begin transaction

	begin try
	
	select LoanTransID, LoanID, TransType, lv.description as TransTypeDesc, TransDate, IntRate, Compound, Freq, PayType, 
		MatDate, StartDate, Amount, StopDate, Principal, Interest, lt.Description, TransferTo, 
		ConvertFrom, lt.RowIsActive, lt.DateModified 
	from LoanTransactions lt(nolock) 
	left join lookupvalues lv(nolock) on lv.Typeid = lt.TransType
	where lt.LoanID = @LoanID
	and (@IsActiveOnly = 0 or lt.RowIsActive = @IsActiveOnly)
	order by lt.DateModified desc

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