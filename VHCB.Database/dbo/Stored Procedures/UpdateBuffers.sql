
create procedure dbo.UpdateBuffers
(
	@ConserveBufferID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveBuffer set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveBuffer 
	where ConserveBufferID = @ConserveBufferID

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