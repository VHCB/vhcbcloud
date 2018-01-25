CREATE procedure [dbo].[GetExistingCommittedFundByProject]
(
	@projId int
)
as
Begin
	select distinct f.FundId, f.name, p.projectid, -sum(det.Amount) as amount from Fund f 
			join detail det on det.FundId = f.FundId
			join Trans tr on tr.TransId = det.TransId
			join Project p on p.ProjectID  = tr.ProjectID
	where p.projectid = @projId and tr.LkTransaction = 240 and tr.lkstatus = 261
	group by f.FundId, f.name, p.ProjectId
end