
create procedure dbo.UpdateProjectLeadData
(
	@ProjectId			int,
	@StartDate			Datetime,
	@UnitsClearDate		Datetime,
	@Grantamt			money,
	@HHIntervention		money,
	@Loanamt			money,
	@Relocation			money,
	@ClearDecom			money,
	@Testconsult		int,
	@PBCont				int,
	@TotAward			money,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ProjectLead set StartDate = @StartDate, UnitsClearDate = @UnitsClearDate, Grantamt = @Grantamt, 
			HHIntervention = @HHIntervention, Loanamt = @Loanamt, Relocation = @Relocation, ClearDecom = @ClearDecom, Testconsult = @Testconsult, 
	PBCont = @PBCont, TotAward = @TotAward, RowIsActive = @RowIsActive
	from ProjectLead
	where ProjectId = @ProjectId
		
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