
CREATE procedure [dbo].[GetFinancialDetails]
as
Begin
--	create table tempFund (projectid int, fundid int, lktranstype int, Date date, PayeeApplicant int, commitmentamount money, expendedamount money)
	delete from tempfund
	insert into tempfund (projectid, fundid, lktranstype, FundType, Projnum, ProjectName, AppID, AppAbbrv, date, PayeeApplicant, Fundabbrv, commitmentamount)
	
	select  p.projectid, det.FundId, det.lktranstype, 
			case
				when det.lktranstype = 241 then 'Grant'
				when det.lktranstype = 242 then 'Loan' 
				when det.lktranstype = 243 then 'Contract'
				
			end as FundType, p.proj_num, lv.Description as projectname, a.applicantid, an.Applicantname,
			tr.Date, tr.PayeeApplicant, f.abbrv,
			sum(det.Amount) as CommitmentAmount
						
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
	
	where tr.LkTransaction in (238,239,240)
	
	group by det.FundId, det.LkTransType , tr.TransId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, tr.Date, tr.PayeeApplicant, f.abbrv, p.ProjectId--, 
	order by p.Proj_num


	insert into tempfund (projectid, fundid, lktranstype, FundType, Projnum, ProjectName, AppID, AppAbbrv, Date, PayeeApplicant, Fundabbrv, expendedamount)
	select  p.projectid, det.FundId, det.lktranstype,			
			case
				when det.lktranstype = 241 then 'Grant'
				when det.lktranstype = 242 then 'Loan' 
				when det.lktranstype = 243 then 'Contract'
				
			end as FundType, p.Proj_num, lv.Description as projectname, a.applicantid, an.Applicantname,
			tr.Date, tr.PayeeApplicant, f.abbrv,

			sum(det.Amount) as ExpendedAmount
						
			from Project p 
	join ProjectName pn on pn.ProjectID = p.ProjectId
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	join ProjectApplicant pa on pa.ProjectId = p.ProjectID		
	join Applicant a on a.ApplicantId = pa.ApplicantId	
	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	join AppName an on an.AppNameID = aan.AppNameID
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	join fund f on f.FundId = det.FundId
	
	where tr.LkTransaction in (236, 237)
	
	group by det.FundId, det.LkTransType,  p.ProjectId, p.Proj_num, a.applicantid, an.Applicantname, lv.Description, tr.Date, tr.PayeeApplicant, f.abbrv
	order by p.Proj_num
	
	select * from tempFund
	
--	drop table #tempfund
End