
create procedure dbo.UpdateHOPWAExp
(
	@HOPWAExpID	int, 
	@Amount			decimal(18, 2),
	@Rent			bit,
	@Mortgage		bit, 
	@Utilities		bit, 
	@PHPUse			int, 
	@Date			date, 
	@DisbursementRecord	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAExp set  Amount = @Amount, Rent = @Rent, 
		Mortgage = @Mortgage, Utilities = @Utilities, PHPUse = @PHPUse, Date = @Date, DisbursementRecord = @DisbursementRecord,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAExp 
	where HOPWAExpID = @HOPWAExpID

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