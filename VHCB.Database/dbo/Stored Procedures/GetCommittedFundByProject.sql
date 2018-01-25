CREATE procedure [dbo].[GetCommittedFundByProject]
(
	@projId int
)
as
Begin
	select distinct f.FundId, f.name, tr.LkTransaction, p.projectid from Fund f 
			join detail det on det.FundId = f.FundId
			join Trans tr on tr.TransId = det.TransId
			join Project p on p.ProjectID  = tr.ProjectID
	where p.projectid = @projId and tr.LkTransaction = 238
	order by f.name asc
end