
create procedure UpdateGrantinfoFYAmt  
(
	@GrantInfoFY	int,
	@Amount			decimal(18, 2),
	@RowIsActive	bit
)
as
begin
--exec UpdateGrantinfoFYAmt 32, 0
	begin try

		update GrantinfoFYAmt set Amount = @Amount, RowIsActive = @RowIsActive
		from GrantinfoFYAmt
		where GrantInfoFY = @GrantInfoFY
	
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
end