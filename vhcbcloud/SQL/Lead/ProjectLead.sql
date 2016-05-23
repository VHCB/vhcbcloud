use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectLeadData]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectLeadData
go

create procedure dbo.AddProjectLeadData
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadDataById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadDataById
go

create procedure [dbo].GetProjectLeadDataById
(
	@ProjectId int
)
as 
--exec GetProjectLeadDataById 20
Begin

	select ProjectLeadID, ProjectId, StartDate, UnitsClearDate, Grantamt, HHIntervention, Loanamt, Relocation, 
		ClearDecom, Testconsult, PBCont, TotAward, RowIsActive, DateModified
	from ProjectLead(nolock) 
	where ProjectId = @ProjectId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectLeadData]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectLeadData
go

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
go
