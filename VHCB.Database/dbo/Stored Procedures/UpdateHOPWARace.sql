
create procedure dbo.UpdateHOPWARace
(
	@HOPWARaceID	int,
	@Race			int,
	@HouseholdNum	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWARace set  Race= @Race, HouseholdNum = @HouseholdNum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWARace 
	where HOPWARaceID = @HOPWARaceID

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