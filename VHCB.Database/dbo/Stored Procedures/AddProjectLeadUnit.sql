CREATE procedure dbo.AddProjectLeadUnit
(
	@LeadBldgID		int, 
	@Unit			int, 
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
		from ProjectLeadUnit plu(nolock)
		where plu.LeadBldgID = @LeadBldgID and Unit = @Unit
	)
	begin
		insert into ProjectLeadUnit(LeadBldgID, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, 
			ClearDate, CertDate, ReCertDate, RelocationAmt, StartDate)
		values(@LeadBldgID, @Unit, @EBLStatus, @HHCount, @Rooms, @HHIncome, @PartyVerified, @IncomeStatus, @MatchFunds, 
			@ClearDate, @CertDate, @ReCertDate, @RelocationAmt, @StartDate)
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  plu.RowIsActive 
		from ProjectLeadUnit plu(nolock)
		where plu.LeadBldgID = @LeadBldgID and Unit = @Unit
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