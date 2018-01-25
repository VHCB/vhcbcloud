
create procedure dbo.GetLoanEventsListByLoanID
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanEventsListByLoanID 1
begin transaction

	begin try
	
	select LoanEventID, LoanID, Description, RowIsActive
	from LoanEvents lm(nolock) 
	where lm.LoanID = @LoanID
	and (@IsActiveOnly = 0 or lm.RowIsActive = @IsActiveOnly)

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