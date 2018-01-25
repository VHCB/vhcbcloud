
create procedure dbo.UpdateConserveAcres
(
	@ConserveAcresID	int,
	--@LkAcres			int, 
	@Acres				int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAcres set  Acres = @Acres,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAcres 
	where ConserveAcresID = @ConserveAcresID

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