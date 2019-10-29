
create procedure dbo.UpdateFund
(
	@FundId			int,
	--@name			nvarchar(35), 
	@abbrv			nvarchar(20), 
	@LkFundType		int, 
	@account		nvarchar(4),
	@LkAcctMethod	int, 
	@DeptID			nvarchar(12),
	@VHCBCode		nvarchar(25),
	@IsMitigationFund	bit = 0,
	@IsRowActive		bit
) as
begin transaction

	begin try

	
		update Fund set --name = @name, 
			abbrv = @abbrv, LkFundType = @LkFundType, 
			account = @account, LkAcctMethod = @LkAcctMethod, DeptID = @DeptID, VHCBCode = @VHCBCode, MitFund = @IsMitigationFund,
			RowIsActive = @IsRowActive
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