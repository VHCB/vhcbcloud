
create procedure dbo.UpdateLoanMaster
(
	@LoanID				int, 
	@Descriptor			nvarchar(75), 
	@TaxCreditPartner	nvarchar(75), 
	@AppName			varchar(150),
	@NoteAmt			decimal(18, 2),
	@NoteOwner			nvarchar(75), 
	@FundID				int,
	@RowIsActive		bit
) as
begin transaction

	begin try

	declare @AppNameID int
	select @AppNameID = appnameid from Appname(nolock) where ApplicantName = @AppName

	update LoanMaster set Descriptor = @Descriptor, NoteAmt = @NoteAmt, TaxCreditPartner = @TaxCreditPartner, ApplicantID = @AppNameID, 
		NoteOwner = @NoteOwner, FundID = @FundID, RowIsActive = @RowIsActive
	from LoanMaster
	where LoanID = @LoanID

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