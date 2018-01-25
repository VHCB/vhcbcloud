
create procedure [dbo].[GetFinancialFundDetails_old]

as
Begin
	
	declare @tempFundCommit table (
	[projectid] [int] NULL,
	[fundid] [int] NULL,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](10) NULL,
	[FundName] nvarchar(35) null,
	[Projnum] [nvarchar](12) NULL,
	[ProjectName] [nvarchar](80) NULL,
	[AppID] [int] NULL,
	[Applicantname] nvarchar(50) null,
	[AppAbbrv] [nvarchar](25) NULL,
	[ProjectCheckReqID] [int] NULL,
	[FundAbbrv] [nvarchar](25) NULL,
	[commitmentamount] [money] NULL,
	[lkstatus] varchar(20) null,
	[Date] [date] NULL	
	)
	
	declare @tempfundExpend table (
	[projectid] [int] NULL,
	[fundid] [int] NULL,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](10) NULL,
	[FundName] nvarchar(35) null,
	[Projnum] [nvarchar](12) NULL,
	[ProjectName] [nvarchar](80) NULL,
	[AppID] [int] NULL,
	[Applicantname] nvarchar(50) null,
	[AppAbbrv] [nvarchar](25) NULL,
	[ProjectCheckReqID] [int] NULL,
	[FundAbbrv] [nvarchar](25) NULL,
	[expendedamount] [money] NULL default 0,
	[lkstatus] varchar(20) null,
	[Date] [date] NULL	
	)

	insert into @tempFundCommit (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, FundAbbrv, commitmentamount, lkstatus, [Date])
	
	select  p.projectid, 
			det.FundId, 
			det.lktranstype, 
			case
				when det.lktranstype = 241 then 'Grant'
				when det.lktranstype = 242 then 'Loan' 
				when det.lktranstype = 243 then 'Contract'
				
			end as FundType, 
			f.name,
			p.proj_num, 
			lv.Description as projectname, 
			a.applicantid, 
			an.Applicantname, 
			an.ApplicantAbbrv,
			tr.ProjectCheckReqID,
			f.abbrv,
			sum(det.Amount) as CommitmentAmount, case 
				when tr.lkstatus = 261 then 'Pending'
				when tr.lkstatus = 262 then 'Final'
			 end as lkStatus, max(tr.date) as TransDate
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
	
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, ProjectCheckReqID, f.name, 
	f.abbrv,an.applicantabbrv,  tr.lkstatus
	order by p.Proj_num


	insert into @tempfundExpend (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, FundAbbrv, expendedamount,lkstatus, [Date])
	
	select  p.projectid, det.FundId, det.lktranstype, 
			case
				when det.lktranstype = 241 then 'Grant'
				when det.lktranstype = 242 then 'Loan' 
				when det.lktranstype = 243 then 'Contract'
				
			end as FundType, f.name,
			p.proj_num, lv.Description as projectname, a.applicantid, an.Applicantname, an.ApplicantAbbrv, tr.ProjectCheckReqID,
			 f.abbrv,sum(det.Amount) as CommitmentAmount, 
			 case 
				when tr.lkstatus = 261 then 'Pending'
				when tr.lkstatus = 262 then 'Final'
			 end as lkStatus,
			 max(tr.date) as TransDate
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
	
	where tr.LkTransaction in (236, 237)
	
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, tr.ProjectCheckReqID, f.name,
	f.abbrv,an.applicantabbrv,  tr.lkstatus
	order by p.Proj_num
	
	select tc.projectid, tc.fundid, tc.lktranstype,tc.FundType, tc.FundName, tc.FundAbbrv, tc.Projnum, tc.ProjectName, tc.AppID, tc.Applicantname, 
		   tc.ProjectCheckReqID, tc.AppAbbrv, tc.commitmentamount, ISNULL( te.expendedamount,0) as expendedamount, (tc.commitmentamount - (ISNULL( te.expendedamount,0))) as balance, tc.lkstatus, tc.Date 
	from @tempFundCommit tc left outer join @tempfundExpend te
	on tc.projectid = te.projectid and tc.fundid = te.fundid and tc.lktranstype = te.lktranstype
	
End