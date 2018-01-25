CREATE procedure [dbo].[GetDisbursements]
as
Begin
	select  tr.date, p.ProjectId, p.proj_num, det.FundId, an.ApplicantAbbrv,
			tr.transid,  tr.LkTransaction, 	
			det.lktranstype, det.amount, tr.LkStatus		
--			sum(det.Amount) as fundamount
						
			from Project p 
	join ProjectName pn on pn.ProjectID = p.ProjectId
	join ProjectApplicant pa on pa.ProjectId = p.ProjectID		
	join Applicant a on a.ApplicantId = pa.ApplicantId	
	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	join AppName an on an.AppNameID = aan.AppNameID
	join LookupValues lv on lv.TypeID = pn.LkProjectname	
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	
--	where tr.LkTransaction = 236
	
	group by tr.date, p.ProjectId, p.Proj_num, det.FundId, det.LkTransType , an.ApplicantAbbrv, tr.TransId, tr.LkTransaction, det.amount, tr.LkStatus
	order by p.Proj_num

End