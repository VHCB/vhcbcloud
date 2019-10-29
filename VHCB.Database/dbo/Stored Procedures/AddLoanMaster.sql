
create procedure dbo.AddLoanMaster
(
	@ProjectID			int, 
	@Descriptor			nvarchar(75), 
	@NoteAmt			decimal(18, 2),
	@TaxCreditPartner	nvarchar(75), 
	@AppName			varchar(150),
	@NoteOwner			nvarchar(75), 
	@FundID				int
) as
begin transaction

	begin try

	declare @AppNameID int
	select @AppNameID = appnameid from Appname(nolock) where ApplicantName = @AppName

	insert into LoanMaster(ProjectID, NoteAmt, Descriptor, TaxCreditPartner, ApplicantID, NoteOwner, FundID)
	values(@ProjectID, @NoteAmt, @Descriptor, @TaxCreditPartner, @AppNameID, @NoteOwner, @FundID)

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