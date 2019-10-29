
create procedure dbo.UpdateFarmAttribute
(
	@FarmAttributeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update FarmAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from FarmAttributes 
	where FarmAttributeID = @FarmAttributeID

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