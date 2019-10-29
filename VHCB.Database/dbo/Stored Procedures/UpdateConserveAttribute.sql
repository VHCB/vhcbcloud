
create procedure dbo.UpdateConserveAttribute
(
	@ConserveAttribID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAttrib set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAttrib 
	where ConserveAttribID = @ConserveAttribID

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