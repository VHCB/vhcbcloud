
create procedure dbo.UpdateOwnerType
(
	@ConserveOTypeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveOType set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveOType 
	where ConserveOTypeID = @ConserveOTypeID

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