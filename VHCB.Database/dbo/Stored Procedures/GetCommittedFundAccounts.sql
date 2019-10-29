

CREATE procedure [dbo].[GetCommittedFundAccounts]
(
	@projectid int
)
as
Begin
		select distinct  det.FundId, f.name , f.account, --ttv.description as FundType, lv.Description as projectname,tr.ProjectCheckReqID,det.lktranstype, 
				 p.proj_num, p.projectid,  f.abbrv
				from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId
		left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where p.projectid = @projectid and f.RowIsActive = 1
			and tr.RowIsActive=1 and pn.DefName =1 
		order by f.account
End