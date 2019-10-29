
create procedure dbo.GetLoanNotesByLoanID
(
	@LoanNoteID			int
) as
--GetLoanNotesByLoanID 1, 1
begin transaction

	begin try
	
	select LoanNoteID, LoanID, LoanNote, FHLink, RowIsActive
	from LoanNotes lm(nolock) 
	where lm.LoanNoteID = @LoanNoteID
	

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