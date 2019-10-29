
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