CREATE procedure [dbo].[GetExpendedFinance]
as
Begin
	select  p.projectid, det.FundId,			
			det.lktranstype,
			sum(det.Amount) as fundamount
						
			from Project p 
	join ProjectName pn on pn.ProjectID = p.ProjectId
	join ProjectApplicant pa on pa.ProjectId = p.ProjectID		
	join Applicant a on a.ApplicantId = pa.ApplicantId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname	
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	
	where tr.LkTransaction in (236, 237)
	
	group by det.FundId, det.LkTransType , p.ProjectId--, tr.TransId
	order by p.ProjectId

End