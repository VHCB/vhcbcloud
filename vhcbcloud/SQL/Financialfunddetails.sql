Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE procedure [dbo].[GetFinancialFundDetailsByProjectId]
(
	@projectid int,
	@isReallocation bit
)
as
Begin
	--exec GetFinancialFundDetailsByProjectId 5612, 1

	if(@isReallocation = 0)
	begin
		declare @tempFundCommit table (
		[projectid] [int] NULL,
		[fundid] [int] NULL,
		[lktranstype] [int] NULL,
		[FundType] [nvarchar](50) NULL,
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
		pendingamount money null ,
		[Date] [date] NULL	
		)
	
		declare @tempfundExpend table (
		[projectid] [int] NULL,
		[fundid] [int] NULL,
		[lktranstype] [int] NULL,
		[FundType] [nvarchar](50) NULL,
		[FundName] nvarchar(35) null,
		[Projnum] [nvarchar](12) NULL,
		[ProjectName] [nvarchar](80) NULL,
		[AppID] [int] NULL,
		[Applicantname] nvarchar(50) null,
		[AppAbbrv] [nvarchar](25) NULL,
		[ProjectCheckReqID] [int] NULL,
		[FundAbbrv] [nvarchar](25) NULL,
		[expendedamount] [money] NULL default 0,
		pendingamount money null ,
		[lkstatus] varchar(20) null,
		[Date] [date] NULL	
		)

		insert into @tempFundCommit (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, 
		FundAbbrv, commitmentamount, lkstatus, pendingamount ,[Date])
	
		select  p.projectid, 
				det.FundId, 
				det.lktranstype, 
								--case
			--	when det.lktranstype = 241 then 'Grant'
			--	when det.lktranstype = 242 then 'Loan' 
			--	when det.lktranstype = 243 then 'Contract'
			--end as FundType, 
				ttv.description as FundType,
				f.name,
				p.proj_num, 
				lv.Description as projectname, 
				a.applicantid, 
				an.Applicantname, 
				an.ApplicantAbbrv,
				tr.ProjectCheckReqID,
				f.abbrv,
				sum(det.Amount) as CommitmentAmount, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 
				 case
					when tr.lkstatus = 261 then sum(det.amount)
				 end as PendingAmount,
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
		left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240)
	
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, ProjectCheckReqID, f.name, 
		f.abbrv,an.applicantabbrv, tr.lkstatus, ttv.description
		order by p.Proj_num


		insert into @tempfundExpend (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, FundAbbrv, expendedamount,lkstatus, pendingamount, [Date])
	
		select  p.projectid, det.FundId, det.lktranstype, 
				--case
				--	when det.lktranstype = 241 then 'Grant'
				--	when det.lktranstype = 242 then 'Loan' 
				--	when det.lktranstype = 243 then 'Contract'
				--end as FundType, 
				ttv.description as FundType,
				f.name,
				p.proj_num, lv.Description as projectname, a.applicantid, an.Applicantname, an.ApplicantAbbrv, tr.ProjectCheckReqID,
				 f.abbrv,sum(det.Amount) as CommitmentAmount, 
				 case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus,
				 case
					when tr.lkstatus = 261 then sum(det.amount)
				 end as PendingAmount,
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
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (236, 237)
	
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, tr.ProjectCheckReqID, f.name,
		f.abbrv,an.applicantabbrv, tr.lkstatus, ttv.description
		order by p.Proj_num
	
		select tc.projectid, tc.fundid, tc.lktranstype,tc.FundType, tc.FundName, tc.FundAbbrv, tc.Projnum, tc.ProjectName, tc.AppID, tc.Applicantname, 
			   tc.ProjectCheckReqID, tc.AppAbbrv, tc.commitmentamount, ISNULL( te.expendedamount,0) as expendedamount, (tc.commitmentamount - (ISNULL( te.expendedamount, 0))) as balance,
			   isnull(tc.pendingamount, 0) as pendingamount, tc.lkstatus, tc.Date 
		from @tempFundCommit tc 
		left outer join @tempfundExpend te on tc.projectid = te.projectid 
				and tc.fundid = te.fundid 
				and tc.lktranstype = te.lktranstype
		where tc.projectid = @projectid

		select  p.projectid, 
				det.FundId, 
				det.lktranstype, 
				--case
				--	when det.lktranstype = 241 then 'Grant'
				--	when det.lktranstype = 242 then 'Loan' 
				--	when det.lktranstype = 243 then 'Contract'
				--	else convert(varchar(5), det.lktranstype)
				
				--end as FundType, 
				ttv.description as FundType,
				case 
					when tr.LkTransaction = 236 then 'Cash Disbursement'
					when tr.LkTransaction = 237 then 'Cash Refund'
					when tr.LkTransaction = 238 then 'Board Commitment'
					when tr.LkTransaction = 239 then 'Board Decommitment'
					when tr.LkTransaction = 240 then 'Board Reallocation'
				end as 'Transaction',
				f.name,
				p.proj_num, 
				lv.Description as projectname, 
				a.applicantid, 
				an.Applicantname, 
				an.ApplicantAbbrv,
				tr.ProjectCheckReqID,
				f.abbrv,
				det.Amount as detail, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 			 
				tr.date as TransDate
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
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240, 236, 237) and p.projectid = @projectid
		order by p.Proj_num
	end
	else
	begin
		exec  [dbo].[GetReallocationFinancialFundDetailsByProjectId] @projectid, @isReallocation
	end
End

go

Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE procedure GetReallocationFinancialFundDetailsByProjectId
(
	@projectid int,
	@isReallocation bit
)
as
begin
	
	declare @temp table 
	(
		transid int,
		ProjId int
	)

	insert into @temp (transid, ProjId)
	select FromTransID, ToProjectId from ReallocateLink where FromProjectId = @projectid
	insert into @temp (transid, ProjId)
	select ToTransID, ToProjectId from ReallocateLink  where FromProjectId = @projectid

	declare @tempFundCommit table (
	[projectid] [int] NULL,
	[fundid] [int] NULL,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](50) NULL,
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
	pendingamount money null ,
	[Date] [date] NULL	
	)
	
	declare @tempfundExpend table (
	[projectid] [int] NULL,
	[fundid] [int] NULL,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](50) NULL,
	[FundName] nvarchar(35) null,
	[Projnum] [nvarchar](12) NULL,
	[ProjectName] [nvarchar](80) NULL,
	[AppID] [int] NULL,
	[Applicantname] nvarchar(50) null,
	[AppAbbrv] [nvarchar](25) NULL,
	[ProjectCheckReqID] [int] NULL,
	[FundAbbrv] [nvarchar](25) NULL,
	[expendedamount] [money] NULL default 0,
	pendingamount money null ,
	[lkstatus] varchar(20) null,
	[Date] [date] NULL	
	)

	insert into @tempFundCommit (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, 
	FundAbbrv, commitmentamount, lkstatus, pendingamount ,[Date])
	select  p.projectid, 
			det.FundId, 
			det.lktranstype, 
			ttv.description as FundType,
			f.name,
			p.proj_num, 
			lv.Description as projectname, 
			a.applicantid, 
			an.Applicantname, 
			an.ApplicantAbbrv,
			tr.ProjectCheckReqID,
			f.abbrv,
			sum(det.Amount) as CommitmentAmount, 
			case 
				when tr.lkstatus = 261 then 'Pending'
				when tr.lkstatus = 262 then 'Final'
			 end as lkStatus, 
			 case
				when tr.lkstatus = 261 then sum(det.amount)
			 end as PendingAmount,
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
	left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
	left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
	where tr.LkTransaction in (238,239,240) --and  tr.TransId in(select distinct transid from @temp)
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, ProjectCheckReqID, f.name, 
	f.abbrv,an.applicantabbrv, tr.lkstatus, ttv.description
	order by p.Proj_num

	insert into @tempfundExpend (projectid, fundid, lktranstype, FundType, FundName, Projnum, ProjectName, AppID, Applicantname, AppAbbrv, ProjectCheckReqID, FundAbbrv, expendedamount,lkstatus, pendingamount, [Date])
	select  p.projectid, det.FundId, det.lktranstype, 
			ttv.description as FundType,
			f.name,
			p.proj_num, lv.Description as projectname, a.applicantid, an.Applicantname, an.ApplicantAbbrv, tr.ProjectCheckReqID,
			 f.abbrv,sum(det.Amount) as CommitmentAmount, 
			 case 
				when tr.lkstatus = 261 then 'Pending'
				when tr.lkstatus = 262 then 'Final'
			 end as lkStatus,
			 case
				when tr.lkstatus = 261 then sum(det.amount)
			 end as PendingAmount,
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
	left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
	where tr.LkTransaction in (236, 237)  and  tr.TransId in(select distinct transid from @temp)
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, a.applicantid, an.Applicantname, tr.ProjectCheckReqID, f.name,
	f.abbrv,an.applicantabbrv, tr.lkstatus, ttv.description
	order by p.Proj_num


	select  tc.projectid, tc.fundid, tc.lktranstype,tc.FundType, tc.FundName, tc.FundAbbrv, tc.Projnum, tc.ProjectName, tc.AppID, tc.Applicantname, 
		   tc.ProjectCheckReqID, tc.AppAbbrv, tc.commitmentamount, ISNULL( te.expendedamount,0) as expendedamount, (tc.commitmentamount - (ISNULL( te.expendedamount, 0))) as balance,
		   isnull(tc.pendingamount, 0) as pendingamount, tc.lkstatus, tc.Date 
	from @tempFundCommit tc 
	left outer join @tempfundExpend te on tc.projectid = te.projectid 
			and tc.fundid = te.fundid 
			and tc.lktranstype = te.lktranstype
	
	select  p.projectid, 
				det.FundId, 
				det.lktranstype, 
				--case
				--	when det.lktranstype = 241 then 'Grant'
				--	when det.lktranstype = 242 then 'Loan' 
				--	when det.lktranstype = 243 then 'Contract'
				--	else convert(varchar(5), det.lktranstype)
				
				--end as FundType, 
				ttv.description as FundType,
				case 
					when tr.LkTransaction = 236 then 'Cash Disbursement'
					when tr.LkTransaction = 237 then 'Cash Refund'
					when tr.LkTransaction = 238 then 'Board Commitment'
					when tr.LkTransaction = 239 then 'Board Decommitment'
					when tr.LkTransaction = 240 then 'Board Reallocation'
				end as 'Transaction',
				f.name,
				p.proj_num, 
				lv.Description as projectname, 
				a.applicantid, 
				an.Applicantname, 
				an.ApplicantAbbrv,
				tr.ProjectCheckReqID,
				f.abbrv,
				det.Amount as detail, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 			 
				tr.date as TransDate
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
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240, 236, 237) and p.projectid = @projectid
		order by p.Proj_num

end

go

CREATE procedure [dbo].[GetCommittedFundAccounts]
as
Begin
	select p.projectid, 
				det.FundId, 
				det.lktranstype, 

				ttv.description as FundType,
				f.name,
				p.proj_num, 
				lv.Description as projectname, 
				
				tr.ProjectCheckReqID,
				f.abbrv,
				sum(det.Amount) as CommitmentAmount, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 
				 case
					when tr.lkstatus = 261 then sum(det.amount)
				 end as PendingAmount,
				 max(tr.date) as TransDate from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId
		left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (236,237,238,239,240)
		
		group by  det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description,  ProjectCheckReqID, f.name, 
		f.abbrv, tr.lkstatus, ttv.description
		order by p.Proj_num
End
go


alter procedure [dbo].[GetCommittedFundDetailsByFundId]
(
	@fundId int
)
as
Begin
	select p.projectid, 
				det.FundId, 
				det.lktranstype, 

				ttv.description as FundType,
				f.name,
				f.account,
				p.proj_num, 
				lv.Description as projectname, 
				
				tr.ProjectCheckReqID,
				f.abbrv,
				sum(det.Amount) as CommitmentAmount, 
				case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus, 
				 case
					when tr.lkstatus = 261 then sum(det.amount)
				 end as PendingAmount,
				 max(tr.date) as TransDate from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId
		left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (236,237,238,239,240)
		and f.fundid = @fundId and  f.RowIsActive=1
		group by  det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description,  ProjectCheckReqID, f.name, 
		f.abbrv, tr.lkstatus, ttv.description, f.account
		order by f.name

End
go


exec GetCommittedFundDetailsByFundId 150

select * from Fund