
create procedure dbo.UpdateHousingSubType
(
	@HousingTypeID		int,
	@Units				int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ProjectHouseSubType set  Units = @Units, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSubType
	where HousingTypeID = @HousingTypeID

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