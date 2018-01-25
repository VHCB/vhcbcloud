CREATE procedure [dbo].[GetFinancialFundDetailsByProjectNumber]
(
    @projectid int,
	@projnum int,
	@isReallocation bit
)
as
Begin
	--exec GetFinancialFundDetailsByProjectNumber 6578, 1

	

		declare @tempFundCommit table (
		[projectid] [int] NULL,
		[fundid] [int] NULL,
		account nvarchar (10)null,
		[lktranstype] [int] NULL,
		[FundType] [nvarchar](50) NULL,
		[FundName] nvarchar(35) null,
		[Projnum] [nvarchar](12) NULL,
		[ProjectName] [nvarchar](80) NULL,
		[ProjectCheckReqID] [int] NULL,
		[FundAbbrv] [nvarchar](25) NULL,
		[commitmentamount] [money] NULL,
		[lkstatus] varchar(20) null,
		[expendedamount] [money] NULL default 0,
		[finaldisbursedamount] [money] NULL default 0,
		pendingamount money null ,
		[Date] [date] NULL	
		)
		if exists (select 1 from ReallocateLink where FromProjectId = @projectid) 
		begin
			set @isReallocation=1
		end
		if exists (select 1 from ReallocateLink where ToProjectId = @projectid) 
		begin
			set @isReallocation=1
		end
		
	if (@isReallocation=1)
	Begin
	insert into @tempFundCommit (projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, ProjectCheckReqID, 
		FundAbbrv, commitmentamount, lkstatus, pendingamount ,[Date])
		select   p.projectid, 
			det.FundId,
			f.account, 
			det.lktranstype, 
	
			ttv.description as FundType,
			f.name,
			p.proj_num, 
			lv.Description as projectname, 
			tr.ProjectCheckReqID,
			f.abbrv,	
			case
				when tr.lkstatus = 262 then det.amount
				end as CommitmentAmount, 
			case 
				when tr.lkstatus = 261 then 'Pending'
				when tr.lkstatus = 262 then 'Final'
				end as lkStatus,
			case
				when tr.lkstatus = 261 then det.amount
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
	where tr.LkTransaction in (238,239,240) and tr.ProjectID = @projectid and
	tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, ProjectCheckReqID, f.name, 
	f.abbrv, tr.lkstatus, ttv.description, f.account, det.Amount
	order by p.Proj_num
	end
	else
	Begin
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
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240) and tr.ProjectID = @projectid and
		tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, ProjectCheckReqID, f.name, 
		f.abbrv, tr.lkstatus, ttv.description, f.account
		order by p.Proj_num
	End

		insert into @tempFundCommit (projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, ProjectCheckReqID, 
		FundAbbrv, expendedamount,lkstatus, finaldisbursedamount, [Date])
	
		select  p.projectid, det.FundId, f.account, det.lktranstype, 
			
				ttv.description as FundType,
				f.name,
				p.proj_num, lv.Description as projectname, tr.ProjectCheckReqID,
				 f.abbrv,
				  case
					when tr.lkstatus = 261 then sum(det.amount)
				 end as pendingdisbursed,
				 
				 case 
					when tr.lkstatus = 261 then 'Pending'
					when tr.lkstatus = 262 then 'Final'
				 end as lkStatus,
				 case
					when tr.lkstatus = 262 then sum(det.amount)
				 end as finaldisbursed,
				 max(tr.date) as TransDate
				from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId		
		join LookupValues lv on lv.TypeID = pn.LkProjectname	
		join Trans tr on tr.ProjectID = p.ProjectId
		join Detail det on det.TransId = tr.TransId	
		join fund f on f.FundId = det.FundId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (236, 237) 
		and tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1 and p.ProjectId = @projectid
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, tr.ProjectCheckReqID, f.name,
		f.abbrv, tr.lkstatus, ttv.description, f.account
		order by p.Proj_num
	
	select projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, FundAbbrv, 
				   sum(isnull( commitmentamount,0)) as commitmentamount,  sum(isnull(pendingamount, 0)) as pendingamount,
				   sum( ISNULL( expendedamount,0)) as expendedamount, sum( ISNULL( finaldisbursedamount,0)) as finaldisbursedamount,
				   case when sum(isnull( commitmentamount,0)) = 0 then 0 
					else
						sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) - ISNULL( expendedamount, 0) - isnull(finaldisbursedamount,0))) 
				   end
				   as balance,
			   max(Date) as [date]
	from @tempFundCommit
	group by projectid, fundid,account, lktranstype,FundType, FundName, FundAbbrv, Projnum, ProjectName


		select distinct p.projectid, 
				det.FundId, f.account,
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
		join fund f on f.FundId = det.FundId
		left join LkTransType_v ttv(nolock) on det.lktranstype = ttv.typeid
		where tr.LkTransaction in (238,239,240, 236, 237)and pn.DefName =1 
		and tr.RowIsActive=1 and det.RowIsActive=1 and p.projectid = @projectid
		order by p.Proj_num


End