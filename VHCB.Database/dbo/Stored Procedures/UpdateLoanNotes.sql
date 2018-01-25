
create procedure dbo.UpdateLoanNotes
(
	@LoanNoteID	int,
	@LoanNote	nvarchar(max), 
	@FHLink		nvarchar(4000),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update LoanNotes set LoanNote = @LoanNote, FHLink = @FHLink,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from LoanNotes
	where LoanNoteID = @LoanNoteID
	
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