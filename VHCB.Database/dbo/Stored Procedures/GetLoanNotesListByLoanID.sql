
create procedure dbo.GetLoanNotesListByLoanID
(
	@LoanID			int,
	@IsActiveOnly	bit
) as
--GetLoanNotesListByLoanID 1, 1
begin transaction

	begin try
	
	select LoanNoteID, LoanID, LoanNote, FHLink, RowIsActive
	from LoanNotes lm(nolock) 
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