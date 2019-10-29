
create procedure dbo.AddFund
(
	@name			nvarchar(35), 
	@abbrv			nvarchar(20), 
	@LkFundType		int, 
	@account		nvarchar(4),
	@LkAcctMethod	int, 
	@DeptID			nvarchar(12) = null,
	@VHCBCode		nvarchar(25) = null,
	@IsMitigationFund	bit = 0,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from Fund(nolock)
		where name = @name 
    )
	begin
		insert into Fund(name, abbrv, LkFundType, account, LkAcctMethod, DeptID, VHCBCode, MitFund)
		values(@name, @abbrv, @LkFundType, @account, @LkAcctMethod, @DeptID, @VHCBCode, @IsMitigationFund)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from Fund(nolock)
		where name = @name 
	end

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