
create procedure dbo.UpdateHOPWAEthnicity
(
	@HOPWAEthnicID	int,
	@Ethnic			int,
	@EthnicNum	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAEthnic set  Ethnic = @Ethnic, EthnicNum = @EthnicNum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAEthnic 
	where HOPWAEthnicID = @HOPWAEthnicID

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