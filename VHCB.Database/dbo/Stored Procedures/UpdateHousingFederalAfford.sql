
create procedure dbo.UpdateHousingFederalAfford
(
	@FederalAffordID	int, 
	@NumUnits			int,
	@IsRowActive		bit
) as
begin transaction

	begin try

	update FederalAfford set NumUnits = @NumUnits, 
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalAfford
	where FederalAffordID = @FederalAffordID
	
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