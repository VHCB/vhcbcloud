
create procedure dbo.UpdateLegalMechanism
(
	@ConserveLegMechID	int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ConserveLegMech set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveLegMech 
	where ConserveLegMechID = @ConserveLegMechID

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