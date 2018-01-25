
create procedure dbo.UpdatePublicAccess
(
	@ConservePAcessID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConservePAccess set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConservePAccess 
	where ConservePAcessID = @ConservePAcessID

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