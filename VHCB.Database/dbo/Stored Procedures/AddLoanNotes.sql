
create procedure dbo.AddLoanNotes
(
	@LoanID			int, 
	@LoanNote		nvarchar(max),
	@FHLink			nvarchar(4000),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1 
		from LoanNotes(nolock)
		where LoanID = @LoanID 
			and LoanNote = @LoanNote
			and FHLink = @FHLink
	)
	begin

		insert into LoanNotes(LoanID, LoanNote, FHLink)
		values(@LoanID, @LoanNote, @FHLink)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from LoanNotes(nolock)
		where LoanID = @LoanID 
			and LoanNote = @LoanNote
			and FHLink = @FHLink
	end

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