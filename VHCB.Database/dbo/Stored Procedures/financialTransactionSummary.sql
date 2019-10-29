CREATE procedure [dbo].[financialTransactionSummary]
as
Begin

	select  p.projectid, p.Proj_num, lv.Description as projectname, 
			tr.transid, tr.date, f.fundid, tr.LkTransaction, 
			case
				when tr.LkTransaction = 236 then 'Cash Disbursement'
				when tr.LkTransaction = 237 then 'Cash Refund' 
				when tr.LkTransaction = 238 then 'Board Commitment'
				when tr.LkTransaction = 239 then 'Board DeCommitment'
				when tr.LkTransaction = 240 then 'Board Reallocation'
				
			end as Funddetail,
			
			det.lktranstype,
			case
				when det.lktranstype = 241 then 'Grant'
				when det.lktranstype = 242 then 'Loan' 
				when det.lktranstype = 243 then 'Contract'
				
			end as FundType,

			a.applicantid, an.Applicantname, 
			f.name as fundname,
			det.Amount as fundamount
						
			from Project p 
	join ProjectName pn on pn.ProjectID = p.ProjectId
	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	join Applicant a on a.ApplicantId = pa.ApplicantId	
	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	join AppName an on an.AppNameID = aan.AppNameID 
	join LookupValues lv on lv.TypeID = pn.LkProjectname	
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	join fund f on f.FundId = det.FundId
	--group by f.FundId
	order by Proj_num
end