
create procedure dbo.UpdateHousingHomeAffordUnits
(
	@ProjectHomeAffordUnitsID	int,
	@Numunits					int,
	@RowIsActive				bit
) as
begin transaction

	begin try

	update ProjectHomeAffordUnits set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHomeAffordUnits
	where ProjectHomeAffordUnitsID = @ProjectHomeAffordUnitsID

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