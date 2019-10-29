
create procedure dbo.UpdateHOPWAProgram
(
	@HOPWAProgramID	int, 
	@Program	int, 
	@Fund		int, 
	@Yr1		bit, 
	@Yr2		bit, 
	@Yr3		bit, 
	@StartDate	date, 
	@EndDate	date, 
	@Notes			nvarchar(max),
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAProgram set  Program = @Program, Fund = @Fund, Yr1 = @Yr1, Yr2 = @Yr2, Yr3 = @Yr3, 
		StartDate = @StartDate, EndDate = @EndDate,  Notes = @Notes, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAProgram 
	where HOPWAProgramID = @HOPWAProgramID

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