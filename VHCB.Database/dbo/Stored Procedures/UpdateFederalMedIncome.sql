
create procedure dbo.UpdateFederalMedIncome
(
	@FederalMedIncomeID	int, 
	@NumUnits		int,
	@IsRowActive	bit
) as
begin transaction

	begin try

	update FederalMedIncome set NumUnits = @NumUnits,
		RowIsActive = @IsRowActive, DateModified = getdate()
	from FederalMedIncome
	where FederalMedIncomeID = @FederalMedIncomeID
	
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