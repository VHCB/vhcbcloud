
CREATE procedure [dbo].[GetFundByProject]
(
	@projId int
)
as
Begin
	select distinct f.FundId, f.name, p.projectid  from Fund f 
			join detail det on det.FundId = f.FundId
			join Trans tr on tr.TransId = det.TransId
			join Project p on p.ProjectID  = tr.ProjectID
	where p.projectid = @projId
	order by f.name
end