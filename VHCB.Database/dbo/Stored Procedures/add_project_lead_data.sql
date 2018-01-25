
create procedure dbo.add_project_lead_data
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
	@TotAward			money
) as
begin transaction

	begin try

	insert into ProjectLead(ProjectId, StartDate, UnitsClearDate, Grantamt, HHIntervention, Loanamt, Relocation, ClearDecom, Testconsult, PBCont, TotAward)
	values(@ProjectId, @StartDate, @UnitsClearDate, @Grantamt, @HHIntervention, @Loanamt, @Relocation, @ClearDecom, @Testconsult, @PBCont, @TotAward)

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