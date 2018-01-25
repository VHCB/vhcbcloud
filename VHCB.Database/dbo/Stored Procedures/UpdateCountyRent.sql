
create procedure dbo.UpdateCountyRent
(
	@CountyRentId	int,
	@FedProgID		int,
	@county			int,
	@StartDate		datetime, 
	@EndDate		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update CountyRents set FedProgID = @FedProgID, county = @county, StartDate = @StartDate, EndDate = @EndDate,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from CountyRents
	where CountyRentId = @CountyRentId
	
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