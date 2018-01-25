
create procedure dbo.UpdateLoanEvent
(
	@LoanEventID	int,
	@Description	nvarchar(max), 
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update LoanEvents set Description = @Description,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from LoanEvents
	where LoanEventID = @LoanEventID
	
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