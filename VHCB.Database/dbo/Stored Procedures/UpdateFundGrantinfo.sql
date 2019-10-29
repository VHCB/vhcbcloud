
create procedure UpdateFundGrantinfo  
(
	@GrantInfoId	int,
	@RowIsActive	bit
)
as
begin
--exec UpdateFundGrantinfo 32, 0
	begin try

		update FundGrantinfo set RowIsActive = @RowIsActive
		from FundGrantinfo
		where GrantinfoID = @GrantInfoId
	
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