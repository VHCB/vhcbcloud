
create procedure dbo.UpdateCountyUnitRent
(
	@CountyUnitRentID	int,
	@HighRent			money, 
	@LowRent			money, 
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update CountyUnitRents set HighRent = @HighRent, LowRent = @LowRent,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from CountyUnitRents
	where CountyUnitRentID = @CountyUnitRentID
	
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