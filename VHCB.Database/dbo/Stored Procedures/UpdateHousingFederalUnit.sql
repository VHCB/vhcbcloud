
create procedure dbo.UpdateHousingFederalUnit
(
	@FederalUnitID	int, 
	@NumUnits		int,
	@IsRowActive	bit
) as
begin transaction

	begin try

	update FederalUnit set NumUnits = @NumUnits, 
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalUnit
	where FederalUnitID = @FederalUnitID
	
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