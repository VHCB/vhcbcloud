
create procedure dbo.UpdateHouseUse
(
	@HouseUseID			int,
	@VHCBTotal			decimal(18, 2),
	@OtherTotal			decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update HouseUse set 
		VHCBTotal = @VHCBTotal, OtherTotal = @OtherTotal, RowIsActive = @RowIsActive, DateModified = getdate()
	from HouseUse where HouseUseID = @HouseUseID

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