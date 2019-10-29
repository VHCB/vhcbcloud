
create procedure dbo.UpdateConserveEvent
(
	@ConserveEventID		int,
	@DispDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveEvent set  DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveEvent 
	where ConserveEventID = @ConserveEventID

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