

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
	account nvarchar (10) null,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](50) NULL,
	[FundName] nvarchar(35) null,
	[Projnum] [nvarchar](12) NULL,
	[ProjectName] [nvarchar](80) NULL,	
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
	account nvarchar (10) null,
	[lktranstype] [int] NULL,
	[FundType] [nvarchar](50) NULL,
	[FundName] nvarchar(35) null,
	[Projnum] [nvarchar](12) NULL,
	[ProjectName] [nvarchar](80) NULL,	
	[ProjectCheckReqID] [int] NULL,
	[FundAbbrv] [nvarchar](25) NULL,
	[expendedamount] [money] NULL default 0,
	pendingamount money null ,
	[lkstatus] varchar(20) null,
	[Date] [date] NULL	
	)

	insert into @tempFundCommit (projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, ProjectCheckReqID, 
	FundAbbrv, commitmentamount, lkstatus, pendingamount ,[Date])
	select  p.projectid, 
			det.FundId, 
			f.account,
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
			 max(tr.date) as TransDate
			from Project p 
	join ProjectName pn on pn.ProjectID = p.ProjectId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname	
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	join fund f on f.FundId = det.FundId
	left join ReallocateLink(nolock) on fromProjectId = p.ProjectId
	left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
	where tr.LkTransaction in (238,239,240) --and  tr.TransId in(select distinct transid from @temp)
	and tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description,  ProjectCheckReqID, f.name, 
	f.abbrv, tr.lkstatus, ttv.description, f.account
	order by p.Proj_num

	insert into @tempfundExpend (projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, ProjectCheckReqID, FundAbbrv, expendedamount,lkstatus, pendingamount, [Date])
	select  p.projectid, det.FundId, f.account,det.lktranstype, 
			ttv.description as FundType,
			f.name,
			p.proj_num, lv.Description as projectname, tr.ProjectCheckReqID,
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
	join LookupValues lv on lv.TypeID = pn.LkProjectname	
	join Trans tr on tr.ProjectID = p.ProjectId
	join Detail det on det.TransId = tr.TransId	
	join fund f on f.FundId = det.FundId
	left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
	where tr.LkTransaction in (236, 237)  and  tr.TransId in(select distinct transid from @temp)
	and tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, tr.ProjectCheckReqID, f.name,
	f.abbrv,f.account, tr.lkstatus, ttv.description
	order by p.Proj_num


	select  tc.projectid, tc.fundid, tc.account, tc.lktranstype,tc.FundType, tc.FundName, tc.FundAbbrv, tc.Projnum, tc.ProjectName, 
		   tc.ProjectCheckReqID, ISNULL(tc.commitmentamount,0) as commitmentamount, ISNULL( te.expendedamount,0) as expendedamount, (ISNULL(tc.commitmentamount,0) - (ISNULL( te.expendedamount, 0))) as balance,
		   isnull(tc.pendingamount, 0) as pendingamount, tc.lkstatus, tc.Date 
	from @tempFundCommit tc 
	left outer join @tempfundExpend te on tc.projectid = te.projectid 
			and tc.fundid = te.fundid 
			and tc.lktranstype = te.lktranstype
	
	select  p.projectid, 
				det.FundId,
				f.account, 
				det.lktranstype, 
			
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
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId and det.rowisactive = 1
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240, 236, 237) and pn.DefName =1 
		and tr.RowIsActive=1 and det.RowIsActive=1 and p.projectid = @projectid
		order by p.Proj_num

end