CREATE procedure dbo.UpdateProjectLeadUnit
(
	@LeadUnitID		int, 
	@EBLStatus		int, 
	@HHCount		int, 
	@Rooms			int, 
	@HHIncome		decimal, 
	@PartyVerified	bit, 
	@IncomeStatus	int, 
	@MatchFunds		decimal, 
	@ClearDate		Datetime, 
	@CertDate		Datetime, 
	@ReCertDate		Datetime,
	@RelocationAmt	decimal(10, 2),
	@StartDate		DateTime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectLeadUnit set	EBLStatus = @EBLStatus, HHCount = @HHCount, Rooms = @Rooms, HHIncome = @HHIncome, 
		PartyVerified = @PartyVerified, IncomeStatus = @IncomeStatus, MatchFunds = @MatchFunds, ClearDate = @ClearDate,
		CertDate = @CertDate, ReCertDate = @ReCertDate, RowIsActive = @IsRowIsActive, DateModified = getdate(), RelocationAmt = @RelocationAmt,
		StartDate = @StartDate
	from ProjectLeadUnit
	where LeadUnitID = @LeadUnitID
	
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