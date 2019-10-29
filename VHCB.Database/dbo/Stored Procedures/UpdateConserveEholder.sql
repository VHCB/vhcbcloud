
create procedure dbo.UpdateConserveEholder
(
	@ConserveEholderID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveEholder set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveEholder 
	where ConserveEholderID = @ConserveEholderID

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