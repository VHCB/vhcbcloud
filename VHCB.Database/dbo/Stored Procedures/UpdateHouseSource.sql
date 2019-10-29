
create procedure dbo.UpdateHouseSource
(
	@HouseSourceID		int,
	@Total				decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update HouseSource set 
		Total = @Total, RowIsActive = @RowIsActive, DateModified = getdate()
	from HouseSource where HouseSourceID = @HouseSourceID

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