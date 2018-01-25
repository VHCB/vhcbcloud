
CREATE procedure dbo.SearchFund
(
	@FundId	 int 
	
) as
begin transaction

	begin try

	select FundId, name, abbrv, LkFundType, account, LkAcctMethod, DeptID, VHCBCode, Drawdown, MitFund, RowIsActive, DateModified
	from Fund(nolock)
	where FundId = @FundId

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