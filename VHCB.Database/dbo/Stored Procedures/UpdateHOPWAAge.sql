
create procedure dbo.UpdateHOPWAAge
(
	@HOPWAAgeId		int,
	@GenderAgeID	int,
	@GANum			int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAAge set  GenderAgeID = @GenderAgeID, GANum = @GANum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAAge 
	where HOPWAAgeId = @HOPWAAgeId

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