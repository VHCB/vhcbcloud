
create procedure dbo.UpdateFarmProducts
(
	@FarmProductsID		int,
	@StartDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update FarmProducts set  StartDate = @StartDate, RowIsActive = @RowIsActive, DateModified = getdate()
	from FarmProducts 
	where FarmProductsID = @FarmProductsID

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