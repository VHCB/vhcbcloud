
alter procedure [dbo].[GetProjects]

as
Begin
	declare @recordId int
	select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
	select	distinct
			lpn.TypeID, 
			p.projectid, 
			lpn.Description,
			pn.DefName, 
			p.Proj_num, 
			pn.LkProjectname
	from Project p 
			join ProjectName pn on p.ProjectId = pn.ProjectID
			join ProjectApplicant pa on pa.ProjectId = p.ProjectId
			join LookupValues lpn on lpn.TypeID = pn.LkProjectname
			join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
			join AppName an on aan.AppNameID = an.appnameid
	where pn.DefName = 1 and p.RowIsActive=1 and lpn.LookupType = @recordId
	order by  p.Proj_num asc
end
go

alter procedure getCommittedProjectslist  
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 --and tr.LkTransaction = 238--and tr.lkstatus = 262--

	and tr.RowIsActive=1 and pn.defname=1
	group by p.projectid, proj_num
	order by proj_num 
end
go

alter procedure getCommittedFinalProjectslistPCR  
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 and tr.lkstatus = 261 --and tr.LkTransaction = 238--and tr.lkstatus = 262--

	and tr.RowIsActive=1 and pn.defname=1
	group by p.projectid, proj_num
	order by proj_num 
end
go

--alter procedure getCommittedFinalProjectslistPCRFilter  
--(
--	@filter varchar(20)
--)
--as
--begin

--	select distinct  proj_num,p.projectid, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
--	,round(sum(tr.TransAmt),2) as availFund
--	from project p(nolock)
--	join projectname pn(nolock) on p.projectid = pn.projectid
--	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
--	join trans tr on tr.projectid = p.projectid
--	where defname = 1 and tr.lkstatus = 261 --and tr.LkTransaction = 238--and tr.lkstatus = 262--

--	and tr.RowIsActive=1 and pn.defname=1 and p.Proj_num like @filter +'%'	
--	group by p.projectid, proj_num
--	order by proj_num 
--end
--go


alter  procedure getCommittedFinalProjectslistPCRFilter  
(
	@filter varchar(20)
)
as
begin

	select distinct  proj_num,p.projectid, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	join projectcheckreq pcr on pcr.Projectid = p.projectid
	where defname = 1 and tr.lkstatus = 261 --and tr.LkTransaction = 238--and tr.lkstatus = 262--
	and 
	(select count(*) from ProjectCheckReqQuestions where ProjectCheckReqID = pcr.ProjectCheckReqID and Approved = 0)>0
/**	and 
	pcr.Voucher# is not null **/ --Dan commented this voucher condition
	
	and tr.RowIsActive=1 and pn.defname=1 and p.Proj_num like @filter +'%'	
	group by p.projectid, proj_num
	order by proj_num  
end
go


alter procedure getCommittedProjectslistNoPendingTrans
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where tr.lkstatus = 262--and tr.LkTransaction = 238	
	and tr.RowIsActive=1 and pn.defname=1
	and p.ProjectId not in (select distinct p.projectid 
							from project p(nolock)
							join projectname pn(nolock) on p.projectid = pn.projectid	
							join trans tr on tr.projectid = p.projectid
							where tr.lkstatus = 261
							and tr.RowIsActive=1 and pn.defname=1)
	group by p.projectid, proj_num
	order by proj_num 
end
go


alter procedure getCommittedPendingProjectslist  
as
begin

	select distinct p.projectid, proj_num, max(rtrim(ltrim(lpn.description))) description,  convert(varchar(25), p.projectid) +'|' + max(rtrim(ltrim(lpn.description))) as project_id_name
	,round(sum(tr.TransAmt),2) as availFund
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 and tr.lkstatus = 261
	and tr.RowIsActive=1 and pn.defname=1
	group by p.projectid, proj_num
	order by proj_num 
end
go


alter procedure GetReallocationFinancialFundDetailsByProjectId
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
go

alter procedure [dbo].[GetFinancialFundDetailsByProjectId]
(
	@projectid int,
	@isReallocation bit
)
as
Begin
	--exec GetFinancialFundDetailsByProjectId 6640, 0

	

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
	where tr.LkTransaction in (238,239,240,26552) and tr.ProjectID = @projectid and
	tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
	group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, ProjectCheckReqID, f.name, 
	f.abbrv, tr.lkstatus, ttv.description, f.account, det.DetailID, det.Amount
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
			case
				when tr.lkstatus = 262 then sum(det.amount)
				end as CommitmentAmount, 
			--sum(det.Amount) as CommitmentAmount, 
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
		where tr.LkTransaction in (238,239,240,26552) and tr.ProjectID = @projectid and
		tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, ProjectCheckReqID, f.name, 
		f.abbrv, tr.lkstatus, ttv.description, det.DetailID, f.account
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
		f.abbrv, tr.lkstatus, ttv.description, det.DetailID, f.account
		order by p.Proj_num
	
	select projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, FundAbbrv, 
				   sum(isnull( commitmentamount,0)) as commitmentamount,  sum(isnull(pendingamount, 0)) as pendingamount,
				   sum( ISNULL( expendedamount,0)) as expendedamount, sum( ISNULL( finaldisbursedamount,0)) as finaldisbursedamount,
					case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
						else
							case when sum(isnull(pendingamount, 0)) > 0 then 
								sum(isnull(commitmentamount,0) - ISNULL( expendedamount, 0) - isnull(finaldisbursedamount,0))
							else
								sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) - ISNULL( expendedamount, 0) - isnull(finaldisbursedamount,0))) 
							end
					end as Oldbalance,
					case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
						 else sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) -(ISNULL( expendedamount, 0) + isnull(finaldisbursedamount,0)))) 
					end as balance,
			   max(Date) as [date]
	from @tempFundCommit
	group by projectid, fundid,account, lktranstype,FundType, FundName, FundAbbrv, Projnum, ProjectName


		select p.projectid, 
				det.FundId, f.account,
				det.lktranstype, 
				
				ttv.description as FundType,
				case 
					when tr.LkTransaction = 236 then 'Cash Disbursement'
					when tr.LkTransaction = 237 then 'Cash Refund'
					when tr.LkTransaction = 238 then 'Board Commitment'
					when tr.LkTransaction = 239 then 'Board Decommitment'
					when tr.LkTransaction = 240 then 'Board Reallocation'
					when tr.LkTransaction = 26552 then 'Staff Assignment'
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
		where tr.LkTransaction in (236,237,238,239,240,26552)and pn.DefName =1 
		and tr.RowIsActive=1 and det.RowIsActive=1 and p.projectid = @projectid
		order by p.Proj_num
End
go


alter procedure [dbo].[GetAllFinancialFundDetailsByProjNum2]
(
        @proj_num varchar(50)
)
as
begin
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
                and tr.RowIsActive=1 and det.RowIsActive=1 and p.Proj_num = @proj_num
                order by p.Proj_num
end

go


alter procedure [dbo].[GetCommittedFundAccounts]
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

go

alter procedure [dbo].[GetCommittedFundNames]
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
		order by f.name
End

go


alter procedure [dbo].[GetCommittedCRFundAccounts]
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
			and tr.RowIsActive=1 and pn.DefName =1 and tr.LkTransaction = 236
		order by f.account
End

go

alter procedure [dbo].[GetCommittedCRFundNames]
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
			and tr.RowIsActive=1 and pn.DefName =1 and tr.LkTransaction = 236
		order by f.name
End

go

alter procedure GetFinancialTransByTransId
(
	@transId int,
	@activeOnly int
)
as
Begin

	if  (@activeOnly=1)
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId				
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.RowIsActive= @activeOnly 	and tr.TransId = @transId and lv.TypeID= 261
	end
	else
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId			
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.TransId = @transId and lv.TypeID= 261
	End
end

go

alter procedure GetFinancialTransByProjId
(
	@projId int,
	@activeOnly int,
	@transType int
)
as
Begin
-- exec GetFinancialTransByProjId 6622, 1
	if  (@activeOnly=1)
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId				
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.RowIsActive= @activeOnly 	and tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
		order by tr.date desc
	end
	else
	Begin
		select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.TypeID ,lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
			join Trans tr on tr.ProjectID = p.ProjectId			
			join LookupValues lv on lv.TypeID = tr.LkStatus
		Where  tr.ProjectID = @projId and lv.TypeID= 261 and tr.LkTransaction = @transType
		order by tr.date desc
	End
end

go


alter procedure ActivateFinancialTransByTransId
(
	@transId int
)
as
begin transaction

	begin try

	update Trans set RowIsActive=1 Where TransId = @transId; 
	update detail set RowIsActive=1 Where TransId = @transId; 

end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go
				
alter procedure InactivateFinancialTransByTransId
(
	@transId int
)
as
begin transaction

	begin try

	update Trans set RowIsActive=0 Where TransId = @transId; 
	update detail set RowIsActive=0 Where TransId = @transId; 

end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

alter procedure [dbo].[GetCommitmentFundDetailsByProjectId]
(	
	@transId int,
	@commitmentType int,
	@activeOnly int
)
as
Begin
-- exec dbo.GetCommitmentFundDetailsByProjectId 409, 239,1
if @activeOnly = 1
	Begin
	if @commitmentType = 238
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and d.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId and t.RowIsActive=1 
		end
	Else if (@commitmentType = 239 or @commitmentType = 237) -- Decommitment or Cash refund
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(-d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId 
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and d.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId and t.RowIsActive=1 
		End
	End
else
	Begin
	if @commitmentType = 238
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction  
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId 
		end
	Else if (@commitmentType = 239 or @commitmentType = 237) -- Decommitment or Cash refund
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(-d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction  
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId 
		End
	End
End
go

alter procedure InactivateFinancialDetailByDetailId
(
	@detailId int
)
as
begin transaction

	begin try
	
	update detail set RowIsActive=0 Where DetailID = @detailId 

end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

alter procedure GetGranteeByProject
(
	@projectId int
)
as
Begin
	select p.projectid, 
		p.Proj_num, lv.Description, a.applicantid, an.Applicantname from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
		join Applicant a on a.ApplicantId = pa.ApplicantId	
		join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
		join AppName an on an.AppNameID = aan.AppNameID 
		join LookupValues lv on lv.TypeID = pa.LkApplicantRole		
	Where  pa.finlegal=1 and p.ProjectId = @projectId
	and pn.defname = 1 and lv.typeid = 358
End

go

alter procedure [dbo].[AddBoardFinancialTransaction]
(
	@projectId int,
	@transDate datetime,
	@transAmt money,
	@payeeApplicant int = null,
	@commitmentType varchar(50),
	@correction	bit,
	@lkStatus int
)
as
Begin
	declare @recordId int
	declare @transTypeId int

	select @recordId = RecordID from LkLookups where Tablename = 'LkTransAction'
	select @transTypeId = TypeID from LookupValues where LookupType = @recordId and Description = @commitmentType
	
	insert into Trans (ProjectID, date, TransAmt, PayeeApplicant, LkTransaction, LkStatus, Correction)
		values (@projectId, @transDate, @transAmt, @payeeApplicant, @transTypeId, @lkStatus, @correction)

	select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, 
		tr.PayeeApplicant, tr.LkTransaction, tr.Correction 
	from Project p 		
		join Trans tr on tr.ProjectID = p.ProjectId	
		join LookupValues lv on lv.TypeID = tr.LkStatus
	Where  tr.RowIsActive=1 	and tr.TransId = @@IDENTITY; 

end
go

alter procedure [dbo].[updateLookups]
(
	@typeId int,
	@description varchar(50),
	@lookupTypeid int,	
	@isActive bit
)
as
--exec updatelookups 97, 'Prime soils', 272, 1
begin transaction

	begin try
		update LookupValues set Description = @description, RowIsActive=@isActive where TypeID = @typeId;
		--update LkLookups set  RowIsActive=@isActive where RecordID = @lookupTypeid;
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;
go

alter procedure [dbo].[GetLkLookupDetails]
 @recordId int
as
begin
	if (@recordId = 0)
	begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		order by lk.Viewname asc, lv.Description asc
	end
	else
	Begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where lk.RecordID = @recordId
		order by   lv.Description asc
	end
end

go

alter procedure IsDuplicateFundDetailPerTransaction 
(
	@transid int,
	@fundid int,	
	@fundtranstype int

)
as
Begin
	select * from Detail where TransId = @transid and FundId = @fundid and LkTransType = @fundtranstype and RowIsActive = 1
End
go

alter procedure IsDuplicateFundDetail 
(
	@detailId int,
	@fundid int,	
	@fundtranstype int

)
as
Begin
	select * from Detail where FundId = @fundid and LkTransType = @fundtranstype and DetailID = @detailId
End
go

alter procedure GetFinancialTransactionDetailDetails
(
	@transId							int
	
)
as
--exec GetFinancialTransactionDetailDetails 1574

begin

	select   
		det.DetailID, det.FundId,fund.name, det.LkTransType, transtype.description, det.Amount
	from Trans trans(nolock)
		join detail det(nolock) on trans.TransId = det.TransId
		join fund fund(nolock) on det.fundid = fund.fundid
		join project_v p(nolock) on trans.Projectid = p.project_id
		join transtype_v transtype(nolock) on det.LKTransType = transtype.typeid
	where trans.TransId = @transId and  p.defname = 1 and trans.RowIsActive=1 and det.RowIsActive = 1
end
go

alter procedure GetFinancialTransactionDetails
(
	@project_id							int,
	@financial_transaction_action_id	int,
	@tran_start_date					datetime,
	@tran_end_date						datetime
	
)
as
--exec GetFinancialTransactionDetails 6637, 238, '05/08/2017', '05/16/2017' 
--exec GetFinancialTransactionDetails 5615, 239, '01/01/2016', '02/01/2016'--DeCommit
--exec GetFinancialTransactionDetails 5615, -1, '01/01/2016', '02/01/2016'--All
--exec GetFinancialTransactionDetails -1, -1, '01/01/2016', '02/07/2016'--All
begin

	if ( @financial_transaction_action_id = 236)
	begin
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, (select crdate from projectcheckreq where ProjectCheckReqID = trans.ProjectCheckReqID  and projectid = @project_id) as TransactionDate, trans.TransAmt, v.description as LkTransactionDesc--, trans.LkTransaction, v.*
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		where trans.TransId in (
			select t.TransId from (
			select case when ((select count(*) from ProjectCheckReqQuestions where ProjectCheckReqID = pcr.ProjectCheckReqID and Approved =0)>0) then 
			 0 else  trans.TransId end as TransId
			 , trans.TransAmt
			 , sum(det.Amount) amount, trans.TransAmt - sum(det.Amount) bal
				from Trans trans(nolock)
					join detail det(nolock) on trans.TransId = det.TransId
					 join ProjectCheckReq pcr on pcr.ProjectCheckReqID = trans.ProjectCheckReqID					 
				where pcr.CRDate >= @tran_start_date 
					and pcr.CRDate <= @tran_end_date 
					and trans.LKStatus = 261 and trans.RowIsActive=1  
									and (trans.projectid = @project_id or (@project_id = -1 and trans.projectid is not null))
					and (trans.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and trans.LkTransaction is not null))
					
			group by trans.TransId, trans.TransAmt, pcr.projectcheckreqid)t
			where t.bal = 0 and pv.defname = 1  
		) order by pv.proj_num
	end
	else 
	begin
		select trans.TransId, pv.project_name ProjectName, pv.proj_num ProjectNumber, trans.Date as TransactionDate, trans.TransAmt, v.description as LkTransactionDesc--, trans.LkTransaction, v.*
		from Trans trans(nolock)
		left join project_v  pv(nolock) on pv.project_id = trans.ProjectID
		left join TransAction_v v(nolock) on v.typeid = trans.LkTransaction
		where trans.TransId in (
			select t.TransId from (
			select trans.TransId as TransId, trans.TransAmt,
					sum(det.Amount) amount, trans.TransAmt - sum(det.Amount) bal
				from Trans trans(nolock)
					join detail det(nolock) on trans.TransId = det.TransId
				where trans.Date >= @tran_start_date 
					and trans. Date <= @tran_end_date 
					and trans.LKStatus = 261 and trans.RowIsActive=1  
									and (trans.projectid = @project_id or (@project_id = -1 and trans.projectid is not null))
					and (trans.LkTransaction = @financial_transaction_action_id or (@financial_transaction_action_id = -1 and trans.LkTransaction is not null))
			group by trans.TransId, trans.TransAmt)t
			where t.bal = 0 and pv.defname = 1  
		) order by pv.proj_num

		--select t.TransId from (
		--select trans.TransId as TransId, trans.TransAmt,
		--			sum(det.Amount) amount, trans.TransAmt - sum(det.Amount) bal
		--		from Trans trans(nolock)
		--			join detail det(nolock) on trans.TransId = det.TransId
		--		where trans.Date >= '01/01/2016' 
		--			and trans. Date <= '02/07/2016'  
		--			and trans.LKStatus = 261
		--			and trans.projectid is not null
		--			and trans.LkTransaction is not null
		--	group by trans.TransId, trans.TransAmt)t
		--	where t.bal = 0

	end
end
go


alter procedure [dbo].[GetProjectsByFilter]
(
	@filter varchar(20)
)
as
Begin
	declare @recordId int
	select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 	
	if(CHARINDEX('-', @filter) > 0)
	begin
		select	distinct			
				top 35 CONVERT(varchar(20), p.Proj_num) as proj_num
		from Project p 
				join ProjectName pn on p.ProjectId = pn.ProjectID
				join ProjectApplicant pa on pa.ProjectId = p.ProjectId
				join LookupValues lpn on lpn.TypeID = pn.LkProjectname
				join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
				join AppName an on aan.AppNameID = an.appnameid
		where pn.DefName = 1 and lpn.LookupType = @recordId and p.Proj_num like @filter +'%'
		order by Proj_num asc
	end
	else 
	Begin
		select	distinct			
				top 35 CONVERT(varchar(20), p.Proj_num) as proj_num
		from Project p 
				join ProjectName pn on p.ProjectId = pn.ProjectID
				join ProjectApplicant pa on pa.ProjectId = p.ProjectId
				join LookupValues lpn on lpn.TypeID = pn.LkProjectname
				join ApplicantAppName aan on aan.ApplicantId = pa.ApplicantId
				join AppName an on aan.AppNameID = an.appnameid
		where pn.DefName = 1 and lpn.LookupType = @recordId and 
		replace(p.proj_num, '-', '') like @filter+ '%'
		order by Proj_num asc
	end
	--select top 20 proj_num from project p where p.Proj_num like @filter +'%'
end
go

alter procedure getCommittedProjectslistByFilter 
(
	@filter varchar(20)
) 
as
begin

	select distinct proj_num
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where defname = 1 --and tr.lkstatus != 261--and tr.LkTransaction = 238
	and tr.RowIsActive=1 and pn.defname=1	and p.Proj_num like @filter +'%'	
	order by proj_num 
end
go

alter procedure getCommittedCashRefundProjectslistByFilter 
(
	@filter varchar(20)
) 
as
begin

	select distinct proj_num
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where tr.lkstatus = 261  and tr.LkTransaction = 236 
	and tr.RowIsActive=1 and pn.defname=1	and p.Proj_num like @filter +'%'	
	order by proj_num 
end
go

alter procedure getCommittedPendingProjectslistByFilter 
(
	@filter varchar(20)
)
as
begin

	select distinct  top 35 p.Proj_num
	from project p(nolock)
	join trans tr on tr.projectid = p.projectid
	where  tr.lkstatus = 261 and tr.LkTransaction = 238 --and pn.defname = 1 and
		and tr.RowIsActive=1 and p.Proj_num like @filter +'%'	
	order by p.proj_num 
end
go

alter procedure getCommittedPendingDecommitmentProjectslistByFilter 
(
	@filter varchar(20)
)
as
begin

	select distinct  top 35 p.Proj_num
	from project p(nolock)
	join trans tr on tr.projectid = p.projectid
	where  tr.lkstatus = 261 and tr.LkTransaction = 239
		and tr.RowIsActive=1 and p.Proj_num like @filter +'%'	
	order by p.proj_num 
end
go

alter procedure getCommittedPendingReallocationProjectslistByFilter 
(
	@filter varchar(20)
)
as
begin

	select distinct  top 35 p.Proj_num
	from project p(nolock)	
	join trans tr on tr.projectid = p.projectid
	where tr.lkstatus = 261 and tr.LkTransaction = 240
		and tr.RowIsActive=1 and p.Proj_num like @filter +'%'	
	order by p.proj_num 
end
go

alter procedure getCommittedPendingCashRefundProjectslistByFilter 
(
	@filter varchar(20)
)
as
begin

	select distinct  top 35 p.Proj_num
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	join trans tr on tr.projectid = p.projectid
	where pn.defname = 1 and tr.lkstatus = 261 and tr.LkTransaction = 237
		and tr.RowIsActive=1 and p.Proj_num like @filter +'%'	
	order by p.proj_num 
end
go

alter procedure GetProjectIdByProjNum
(
	@filter varchar(20)
)
as
Begin
	select p.projectid, ltrim(lpn.description) as projName
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	 where p.proj_num = @filter
End
go


alter procedure GetFundAccountsByFilter
( @filter varchar(20))
as
Begin
	select top 20 fundid, account, name from Fund 
	where  RowIsActive = 1 and account like  @filter +'%'
	order by account asc
End
go

alter procedure [dbo].[GetFundAccounts]
as
Begin
	select fundid, account, name from Fund 
	where  RowIsActive = 1 
	order by account asc
End
go


alter procedure [dbo].[GetFundNames]
as
Begin
	select fundid, account, name from Fund 
	where  RowIsActive = 1 
	order by name asc
End
go

alter procedure [dbo].[GetFinancialPendingTransactionFundDetails]
as
Begin
	
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
		where tr.LkTransaction in (238,239,240) and
		tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, ProjectCheckReqID, f.name, 
		f.abbrv, tr.lkstatus, ttv.description, f.account
		order by p.Proj_num


		insert into @tempfundExpend (projectid, fundid, account, lktranstype, FundType, FundName, Projnum, ProjectName, ProjectCheckReqID, FundAbbrv, expendedamount,lkstatus, pendingamount, [Date])
	
		select  p.projectid, det.FundId, f.account, det.lktranstype, 
				--case
				--	when det.lktranstype = 241 then 'Grant'
				--	when det.lktranstype = 242 then 'Loan' 
				--	when det.lktranstype = 243 then 'Contract'
				--end as FundType, 
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
		where tr.LkTransaction in (236, 237) 
		and tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1
		group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, tr.ProjectCheckReqID, f.name,
		f.abbrv, tr.lkstatus, ttv.description, f.account
		order by p.Proj_num
	
		select tc.projectid, tc.fundid,tc.account, tc.lktranstype,tc.FundType, tc.FundName, tc.FundAbbrv, tc.Projnum, tc.ProjectName, 
			   tc.ProjectCheckReqID, tc.commitmentamount, ISNULL( te.expendedamount,0) as expendedamount, (tc.commitmentamount - (ISNULL( te.expendedamount, 0))) as balance,
			   isnull(tc.pendingamount, 0) as pendingamount, tc.lkstatus, tc.Date 
		from @tempFundCommit tc 
		left outer join @tempfundExpend te on tc.projectid = te.projectid 
				and tc.fundid = te.fundid 
				and tc.lktranstype = te.lktranstype
		where tc.lkstatus='pending'
end
go

alter procedure GetLandUsePermit
(
	 @projectId int
)
as
 Begin
	--select af.UsePermit, af.Act250FarmId from Act250Farm af join Act250Projects ap on ap.Act250FarmId = af.Act250FarmId where ap.RowIsActive=1
	--and ap.projectid = @projectId
	select distinct af.UsePermit, af.Act250FarmId from Act250Farm af 
		join detail d on d.landusepermitid = af.Act250FarmID
		join Trans tr on tr.TransId = d.TransId
	where tr.ProjectID = @projectid
 end
go

--alter procedure GetAllLandUsePermit
--as
--begin
--	select af.UsePermit, af.Act250FarmId from Act250Farm af where af.RowIsActive=1
--end
--go

 alter procedure GetAllLandUsePermit
 (
	 @projectId int
 )
as
begin
	
	declare @lkprogram int 
	set @lkprogram = (select LkProgram from Project where ProjectId = @projectid)

	select distinct af.UsePermit, af.Act250FarmId, * from Act250Farm af 
	left join Act250Projects ap on ap.Act250FarmID = af.Act250FarmID 	
	where af.RowIsActive=1 and af.type = @lkprogram
end
go

alter procedure [dbo].[AddProjectFundDetails]
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money
)
as

BEGIN 
	insert into Detail (TransId, FundId, LkTransType, Amount)	values
		(@transid,@fundid , @fundtranstype, @fundamount);
		
END 
go

alter procedure [dbo].AddProjectFundDetailsWithLandPermit
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money,
	@LandUsePermit nvarchar(15),
	@LandUseFarmId int
)
as

BEGIN 
	insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitid)	values
		(@transid,@fundid , @fundtranstype, @fundamount, @LandUseFarmId)

	insert into act250devpay (Act250FarmId, FundId, AmtRec, DateRec) values
			(@LandUseFarmId, @fundid, @fundAmount, getdate())
END 
go

alter procedure GetVHCBProgram
as
Begin
	select typeid, description from LookupValues 
	where lookuptype = 34 and RowIsActive = 1
end
go

alter procedure UpdateUserInfo
(
	@userid		int,
	@Fname		varchar(40), 
	@Lname		varchar(50), 
	@password	varchar(40), 
	@email		varchar(150),
	@DfltPrg	int
)
as
begin

	declare @Username	varchar(100)

	set @Username = lower(left(@Fname, 1) + @Lname)

	update UserInfo set Fname = @Fname, Lname = @Lname, Username = @Username, email = @email, password = @password, DfltPrg = @DfltPrg 
	where userid = @userid
	
end 
go

alter procedure AddUserInfo
(
	@Fname		varchar(40), 
	@Lname		varchar(50), 
	@password	varchar(40), 
	@email		varchar(150),
	@DfltPrg	int
)
as
begin

	declare @Username	varchar(100)

	set @Username = lower(left(@Fname, 1) + @Lname)

	insert into UserInfo(usergroupid, Fname, Lname, Username, password, email, DfltPrg) values 
			(0, @Fname, @Lname, @Username, @password, @email, @DfltPrg)
end
go

alter procedure GetUserInfo
as
begin
--exec GetUserInfo
	select ui.userid, ui.Fname, ui.Lname, ui.Username, ui.password, ui.email, lv.typeid, ui.DfltPrg, lv.description
		from UserInfo ui(nolock)
		left outer join LookupValues lv on lv.typeid = ui.DfltPrg
	 order by ui.DateModified desc 
end
go


alter view vw_FinancialDetailSummary
as
	select  p.projectid, 
				det.FundId, f.account,
				det.lktranstype, 
				ttv.typeid,				
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
		and tr.RowIsActive=1 and det.RowIsActive=1 --and p.projectid = @projectid
		
go

alter procedure GetAvailableTransTypesPerProjAcct
(
	@account varchar(20),
	@projectid int
)
as
Begin
	select distinct projectid,fundid,account,typeid,fundtype,name, proj_num,projectname,sum(detail) as availFunds
	from vw_FinancialDetailSummary where account = @account and projectid = @projectid
	group by projectid,fundid,account,typeid,fundtype,name, proj_num,projectname
end
go

alter procedure GetAvailableTransTypesPerProjFundId
(
	@fundId int,
	@projectid int
)
as
Begin
	select distinct projectid,fundid,account,typeid,fundtype,name, proj_num,projectname,sum(detail) as availFunds
	from vw_FinancialDetailSummary where fundid = @fundId and projectid = @projectid
	group by projectid,fundid,account,typeid,fundtype,name, proj_num,projectname
end
go


alter procedure GetCommittedFundPerProject
(
	@proj_num varchar(20)
)
as
Begin
	select distinct projectid, proj_num,projectname, sum(detail) as availFunds  from vw_FinancialDetailSummary where proj_num = @proj_num
	group by projectid,proj_num,projectname
end
go

alter procedure GetAvailableFundsPerProjAcctFundtype
(
	@account varchar(20),
	@projectid int,
	@fundtypeId int
)
as
Begin
	select distinct projectid,fundid,account,typeid,fundtype,name, proj_num,projectname,sum(detail) as availFunds
	from vw_FinancialDetailSummary where account = @account and projectid = @projectid and typeid = @fundtypeId
	group by projectid,fundid,account,typeid,fundtype,name, proj_num,projectname
end
go

alter procedure [dbo].[GetFundByProject]
(
	@projId int
)
as
Begin
	select distinct f.FundId, f.name, p.projectid  from Fund f 
			join detail det on det.FundId = f.FundId
			join Trans tr on tr.TransId = det.TransId
			join Project p on p.ProjectID  = tr.ProjectID
	where p.projectid = @projId
	order by f.name
end
go

alter procedure [dbo].[GetExistingCommittedFundByProject]
(
	@projId int
)
as
Begin
	select distinct f.FundId, f.name, p.projectid, -sum(det.Amount) as amount from Fund f 
			join detail det on det.FundId = f.FundId
			join Trans tr on tr.TransId = det.TransId
			join Project p on p.ProjectID  = tr.ProjectID
	where p.projectid = @projId and tr.LkTransaction = 240 and tr.lkstatus = 261
	group by f.FundId, f.name, p.ProjectId
end
go

alter procedure UpdateFinancialTransactionStatus
(
	@transId int
	
)
as
--exec UpdateFinancialTransactionStatus 2958
begin
	
	declare @toProjId int
	declare @lkTrans int

	select @lkTrans = LkTransaction from trans where TransId = @transId
	
	if (@lkTrans = 240)
	Begin

		declare  @ProjIdTable table(projIds int)
		declare  @transIdTable table(transIds int)

		select @toProjId= toprojectid from reallocatelink where totransid = @transid

		insert into @ProjIdTable(projIds) select toprojectid from reallocatelink where fromprojectid = @toProjId
		insert into @transIdTable(transIds)  select fromtransid from reallocatelink where toprojectid in (select projids from @ProjIdTable)
		insert into @transIdTable(transIds)  select totransid from reallocatelink where toprojectid in (select projids from @ProjIdTable)
	

		update trans set LKStatus = 262		
		where TransId in (select distinct transIds from @transIdTable) 
	end
	else 
	Begin
		update trans set LKStatus = 262		
		where TransId = @transId
	end
end
go

alter procedure PCR_ApplicantName
(
	@ProjectID int
)
as
begin

	select an.Applicantname 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantID = a.ApplicantID
	where aan.DefName = 1 and pa.LkApplicantRole=358 and projectID = @ProjectID
	order by an.Applicantname
end
go


alter procedure dbo.GetProjectFinLegalApplicant
(
	@ProjectId int
) 
as
begin 
	select pa.ProjectApplicantID, 			
			isnull(pa.IsApplicant, 0) as IsApplicant, 
			isnull(pa.FinLegal, 0) as FinLegal,			
			a.ApplicantId, a.Individual, 
			an.applicantname,			
			aan.appnameid, aan.defname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @ProjectId
			and pa.RowIsActive = 1 and pa.finlegal = 1
		order by pa.IsApplicant desc, pa.FinLegal desc, pa.DateModified desc
	end 
go

alter procedure GetDefaultPCRQuestions
(
@IsLegal bit = 0,
@ProjectCheckReqID	int
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	select pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, 
	case when pcrq.Approved = 1 then 'Yes'
		else 'No' end as Approved , pcrq.Date, --ui.fname+', '+ui.Lname   as staffid ,
	case when pcrq.Approved != 1 then ''
		else ui.fname+' '+ui.Lname  end as staffid 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	left join UserInfo ui on pcrq.StaffID = ui.UserId
	where   q.RowIsActive=1 and ProjectCheckReqID = @ProjectCheckReqID
	
end

go

alter procedure [dbo].[GetFundDetailsByFundId]
(
	@fundId int
)
as
Begin
	select lft.FundId, lft.account, lft.name, lft.abbrv, lft.VHCBCode,lft.LkAcctMethod, lft.mitfund,
	lft.DeptID,lft.Drawdown, lv.description, lft.LkFundType
	from Fund lft
	join LkFundType lv on lv.typeid = lft.lkfundtype
	where lft.FundId = @fundId and  lft.RowIsActive=1
	order by lft.name asc, lft.DateModified desc
	
End
go

alter procedure GetFundDetailsByFundAcct
(
	@fundAcct varchar(50)
)
as
Begin
	select lft.FundId, lft.account, lft.name, lft.abbrv, lft.VHCBCode,lft.LkAcctMethod, 
	lft.DeptID,lft.Drawdown, lv.description, lft.LkFundType
	from Fund lft
	join LkFundType lv on lv.typeid = lft.lkfundtype
	where lft.account = @fundAcct and  lft.RowIsActive=1
	order by lft.name asc, lft.DateModified desc
	
End
go

alter procedure [dbo].[GetReallocationDetailsTransId]
(	
	@fromProjId int
	--,@toTransId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId
		--right outer join #temp te on te.transid = t.transid
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and t.TransId in(select distinct transid from @temp)
	 --and p.ProjectId in (select distinct toprojid from #temp)
	order by d.DateModified desc

End

go


alter procedure [dbo].[GetReallocationDetailsProjFund]
(	
	@fromProjId int,
	@fundId int, 
	@dateModified date
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and f.fundid = @fundid 
	and CONVERT(VARCHAR(101),t.datemodified,110)   =  CONVERT(VARCHAR(101),@dateModified,110) 
	and t.TransId in(select distinct transid from @temp)
	order by d.DateModified desc

End

go

alter procedure [dbo].GetReallocationDetailsProjFundTransType
(	
	@fromProjId int,
	@fundId int,
	@transTypeId int,
	@dateModified date,
	@guid varchar(100)
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select distinct t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified, f.name as fundName
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @temp td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.lkstatus = 261
	--and f.fundid = @fundid 
	--and d.lktranstype = @transTypeId
	and t.TransId in(select transid from @temp)
	and CONVERT(VARCHAR(101),t.datemodified,110)   =  CONVERT(VARCHAR(101),@dateModified,110)
	and td.projguid = @guid
	order by d.detailid 

End

go


alter procedure [dbo].GetDistinctReallocationGuidsByProjFundTransType
(	
	@fromProjId int,
	@fundId int,
	@transTypeId int,
	@dateModified date
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select distinct td.projguid
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and f.fundid = @fundid and d.lktranstype = @transTypeId
	and t.TransId in(select distinct transid from @temp)
	and CONVERT(VARCHAR(101),t.datemodified,110)   =  CONVERT(VARCHAR(101),@dateModified,110) 
	

End

go


alter procedure [dbo].[GetReallocationDetailsNewProjFund]
(	
	@fromProjId int,
	@fundId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and f.fundid = @fundid 
	and t.TransId in(select distinct transid from @temp)
	order by d.DateModified desc

End

go

alter procedure [dbo].GetReallocationDetailsNewProjFundTransType
(	
	@fromProjId int,
	@fundId int,
	@transTypeId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and f.fundid = @fundid and d.lktranstype = @transTypeId
	and t.TransId in(select distinct transid from @temp)
	
	order by d.DateModified desc

End

go



alter procedure [dbo].[GetReallocationAmtByProjId]
(	
	@fromProjId int	
)
as
Begin	
	
	create table #temp ( transid int, toProjId int )
	insert into #temp (transid, toProjId)
	select FromTransID, ToProjectId from ReallocateLink where FromProjectId = @fromProjId
	insert into #temp (transid, toProjId)
	select ToTransID, ToProjectId from ReallocateLink  where FromProjectId = @fromProjId

	Select  format(sum(d.Amount), 'N2') as amount  from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and d.amount > 0 and t.lkstatus = 261
	and t.TransId in(select distinct transid from #temp)
	group by LkTransaction	 
	

End

go


alter procedure [dbo].[AddBoardReallocationTransaction]
(
	@FromProjectId int,
	@ToProjectId int,
	@transDate datetime,		

	@Fromfundid int,	
	@Fromfundtranstype int,
	@Fromfundamount money,

	@Tofundid int,	
	@Tofundtranstype int,
	@Tofundamount money,
	@fromTransId int = null,
	@toTransId int = null, 
	@transGuid varchar(50) = null,
	@fromUsePermit int = null,
	@toUsePermit int = null
)
as
Begin	
	--declare @fromPayeeapplicant int 
	--declare @ToPayeeApplicant int

	--select @fromPayeeapplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname
	--Where  a.finlegal=1 and p.ProjectId = @FromProjectId

	--select @ToPayeeApplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname		
	--Where  a.finlegal=1 and p.ProjectId = @ToProjectId

	--if(@toTransId >0)
	--	Begin
	--		insert into Detail (TransId, FundId, LkTransType, Amount)	values
	--				(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
	--		insert into ReallocateLink(fromprojectid, fromtransid, totransid) values
	--				(@FromProjectId, @fromTransId,@toTransId)
	--	End
	--Else
		

		if (@FromProjectId != @ToProjectId)
		Begin
			
			if(@toTransId >0)
			Begin
				insert into Detail (TransId, FundId, LkTransType, Amount,LandUsePermitID )	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @fromUsePermit)

				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount, @toUsePermit)
			end
			else
			begin

				--set @Fromfundamount = @Fromfundamount -@Tofundamount

				insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt)
					values (@FromProjectId, @transDate, 0, 240, 261,-@Fromfundamount)-- 240 Board Reallocation, 261 Pending
				set @fromTransId = @@IDENTITY;
	
				insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt)
					values (@ToProjectId, @transDate, 0, 240, 261, @Fromfundamount)
				set @toTransId = @@IDENTITY;
				
				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @fromUsePermit)

				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount, @toUsePermit)			
				
			end
		end
		else
		Begin

			if(@toTransId >0)
			Begin
				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @fromUsePermit)

				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount, @toUsePermit)
			end
			else
			begin			
				insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt)
					values (@FromProjectId, @transDate, 0, 240, 261, -@Fromfundamount) -- 240 Board Reallocation, 261 Pending
				set @fromTransId = @@IDENTITY;
				set @toTransId = @@IDENTITY;

				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount, @fromUsePermit)

				insert into Detail (TransId, FundId, LkTransType, Amount, LandUsePermitID)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount, @toUsePermit)
			end

		End

		insert into ReallocateLink(fromprojectid, fromtransid, ToProjectId, totransid, ReallocateGUID) values
				(@FromProjectId, @fromTransId, @ToProjectId, @toTransId, @transGuid)
		

		Select @fromTransId as FromTransId, @toTransId as ToTransId
end

go

alter procedure [dbo].[GetReallocationDetailsByGuid]
(	
	@fromProjId int
	,@reallocateGuid varchar(50)
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where FromProjectId = @fromProjId and ReallocateGUID = @reallocateGuid
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId  and ReallocateGUID = @reallocateGuid

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	

	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId
		, td. projGuid, t.datemodified
	
	 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.transid
	Where     f.RowIsActive=1 and t.LkTransaction = 240
	and t.TransId in(select distinct transid from @temp)
	--and p.ProjectId in (select distinct toprojid from #temp)
	order by d.DateModified desc

End
go

alter procedure DeleteReallocationsByGUID
(
	@reallocateGUID varchar(100)
)
as
Begin
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where ReallocateGUID = @reallocateGuid
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where ReallocateGUID = @reallocateGuid

	delete reallocatelink where reallocateguid = @reallocateGUID
	delete Detail where transid in (select distinct transid from @temp)
	delete Trans where transid in (select distinct transid from @temp)
End
go


alter procedure DeleteReallocationTrans
(
	@transId int
)
as
Begin
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where FromTransID = @transId
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromTransID = @transId

	delete reallocatelink where FromTransID in (select transid from @temp)
	delete reallocatelink where ToTransID in (select transid from @temp)
	delete Detail where transid in (select  transid from @temp)
	delete Trans where transid in (select  transid from @temp)
End
go


alter procedure GetExistingPCR
as
Begin
	select pcr.ProjectID, pcr.ProjectCheckReqId, 
	CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	join LookupValues lv on lv.TypeID = t.LkStatus
	where pv.defname = 1
	order by pcr.ProjectCheckReqId desc
End
go

alter procedure GetExistingPCRByProjId
(
	@projId int
)
as
Begin
	
	declare @payee varchar (100)
	set @payee = (select top 1 an.applicantname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @projId
			and pa.RowIsActive = 1 and pa.finlegal = 1
		order by pa.IsApplicant desc, pa.FinLegal desc, pa.DateModified desc)

	select pcr.ProjectID, pv.project_name, pcr.legalreview,pcr.LCB, pcr.initdate, pcr.ProjectCheckReqId, pcr.crdate,
	t.TransAmt, t.transid, an.Applicantname, @payee as Payee,
	CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	join LookupValues lv on lv.TypeID = t.LkStatus
	where pv.defname = 1 and pcr.projectid = @projId and t.LkStatus = 261 --Dan added LKstatus =261
	order by pcr.ProjectCheckReqId desc

	
End
go




alter procedure dbo.AddProjectNotes
(
	@ProjectId	int,
	@UserName	nvarchar(100),
	@Lkcategory int, 
	@Date		DateTime,
	@Notes		nvarchar(max),
	@pcrid		int = null
)
as
begin transaction

	begin try

		declare @UserId int
		
		select @UserId = UserId 
		from UserInfo(nolock) 
		where  rtrim(ltrim(Username)) = @UserName 

		insert into ProjectNotes(ProjectId,  LkCategory, UserId, Date, Notes, ProjectCheckReqID)
		values(@ProjectId, @Lkcategory, @UserId, @Date, @Notes, @pcrid)

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
		RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;

go


alter procedure [dbo].[GetAllFinancialFundDetailsByProjNum]
(
	@proj_num varchar(50)
)
as
Begin

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
		declare @projectid int
		declare @isReallocation bit

		select @projectid = ProjectID from project where proj_num = @proj_num
		
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
						case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
							else
								case when sum(isnull(pendingamount, 0)) > 0 then 
									sum(isnull(commitmentamount,0) - ISNULL( expendedamount, 0) - isnull(finaldisbursedamount,0))
								else
									sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) - ISNULL( expendedamount, 0) - isnull(finaldisbursedamount,0))) 
								end
						end as Oldbalance,
						case when sum(isnull( commitmentamount,0) +  isnull( pendingamount,0)) <= 0 then 0  
							 else sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) -(ISNULL( expendedamount, 0) + isnull(finaldisbursedamount,0)))) 
						end as balance,
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
go


alter procedure DeleteTransactionDetail
(
	@detailId int
)
as
Begin
	Delete from Detail where DetailID = @detailId
End
go

alter procedure GetDefaultPCRQuestions
(
@IsLegal bit = 0,
@ProjectCheckReqID	int
)
as
begin
--Always include LkPCRQuestions.def=1 If any disbursement from  ProjectCheckReq.Legalreview=1 (entered above), then include LkPCRQuestions.TypeID=7

	select pcrq.ProjectCheckReqQuestionID, q.Description, pcrq.LkPCRQuestionsID, 
	case when pcrq.Approved = 1 then 'Yes'
		else 'No' end as Approved , pcrq.Approved as chkApproved, pcrq.Date, --ui.fname+', '+ui.Lname   as staffid ,
	case when pcrq.Approved != 1 then ''
		else ui.fname+' '+ui.Lname  end as staffid 
	from ProjectCheckReqQuestions pcrq(nolock) 
	left join  LkPCRQuestions q(nolock) on pcrq.LkPCRQuestionsID = q.TypeID 
	left join UserInfo ui on pcrq.StaffID = ui.UserId
	where   q.RowIsActive=1 and ProjectCheckReqID = @ProjectCheckReqID
	
end
go

alter procedure getAvailableFundsByProject  
	@projId int
as
begin

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
			declare @isReallocation bit
			if exists (select 1 from ReallocateLink where FromProjectId = @projId) 
			begin
				set @isReallocation=1
			end
			if exists (select 1 from ReallocateLink where ToProjectId = @projId) 
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
		where tr.LkTransaction in (238,239,240) and tr.ProjectID = @projId and
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
				case
					when tr.lkstatus = 262 then sum(det.amount)
					end as CommitmentAmount, 
				--sum(det.Amount) as CommitmentAmount, 
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
			where tr.LkTransaction in (238,239,240) and tr.ProjectID = @projId and
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
			and tr.RowIsActive=1 and pn.DefName =1 and det.rowisactive = 1 and p.ProjectId = @projId
			group by det.FundId, det.LkTransType ,  p.ProjectId, p.Proj_num, lv.Description, tr.ProjectCheckReqID, f.name,
			f.abbrv, tr.lkstatus, ttv.description, f.account
			order by p.Proj_num

			declare @tempAvailFunds table (
				[projectid] [int] NULL,
				[fundid] [int] NULL,
				[commitmentamount] [money] NULL,	
				[pendingcommitted] [money] NULL,			
				[pendingdisburse] [money] NULL ,
				[finaldisbursedamount] [money] NULL ,
				[provisionalbalance] money null 			
			)
	
			insert into @tempAvailFunds (projectid, fundid,commitmentamount, pendingcommitted, pendingdisburse, finaldisbursedamount, provisionalbalance)
			select projectid, fundid,  
						   sum(isnull( commitmentamount,0)) as commitmentamount,  
						   sum(isnull(pendingamount, 0)) as pendingamount,
						   sum( ISNULL( expendedamount,0)) as expendedamount, 
						   sum( ISNULL( finaldisbursedamount,0)) as finaldisbursedamount,
						
							case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
								 else sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) -(ISNULL( expendedamount, 0) + isnull(finaldisbursedamount,0)))) 
							end as balance
			from @tempFundCommit
			group by projectid, fundid,account, lktranstype,FundType, FundName, FundAbbrv, Projnum, ProjectName

			--select * from @tempFundCommit

			select projectid,  
				case when sum(isnull(commitmentamount,0)) <= 0 then 0 
				else
					(sum(isnull(commitmentamount,0))- ( sum(isnull (pendingdisburse,0))+ sum(isnull(finaldisbursedamount,0)))) 
				end as availFund from @tempAvailFunds
			group by projectid


	--select distinct p.projectid, proj_num, round(sum(tr.TransAmt),2) as availFund
	--from project p(nolock)
	--join projectname pn(nolock) on p.projectid = pn.projectid
	--join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	--join trans tr on tr.projectid = p.projectid
	--where defname = 1 --and tr.LkTransaction = 238 
	--and p.ProjectId = 6637
	--group by p.projectid, proj_num
	--order by proj_num 
	
end
go

alter procedure [dbo].[GetCommittedFundDetailsByFundId]
(
	@projectid int,
	@fundId int

)
as
Begin
--exec [GetCommittedFundDetailsByFundId] 6637, 209
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
			declare @isReallocation bit
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
				case
					when tr.lkstatus = 262 then sum(det.amount)
					end as CommitmentAmount, 
				--sum(det.Amount) as CommitmentAmount, 
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

			declare @tempAvailFunds table (
				[projectid] [int] NULL,
				[fundid] [int] NULL,
				[commitmentamount] [money] NULL,	
				[pendingcommitted] [money] NULL,			
				[pendingdisburse] [money] NULL ,
				[finaldisbursedamount] [money] NULL ,
				[provisionalbalance] money null 			
			)
	
			insert into @tempAvailFunds (projectid, fundid,commitmentamount, pendingcommitted, pendingdisburse, finaldisbursedamount, provisionalbalance)
			select projectid, fundid,  
						   sum(isnull( commitmentamount,0)) as commitmentamount,  
						   sum(isnull(pendingamount, 0)) as pendingamount,
						   sum( ISNULL( expendedamount,0)) as expendedamount, 
						   sum( ISNULL( finaldisbursedamount,0)) as finaldisbursedamount,
						
							case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
								 else sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) -(ISNULL( expendedamount, 0) + isnull(finaldisbursedamount,0)))) 
							end as balance
			from @tempFundCommit where fundid = @fundId
			group by projectid, fundid,account, lktranstype,FundType, FundName, FundAbbrv, Projnum, ProjectName

			--select * from @tempFundCommit

			select projectid, fundid, 
				case when sum(isnull(commitmentamount,0)) <= 0 then 0 
				else
					(sum(isnull(commitmentamount,0))- ( sum(isnull (pendingdisburse,0))+ sum(isnull(finaldisbursedamount,0)))) 
				end as balance from @tempAvailFunds
			group by projectid, fundid

End

go

alter procedure [dbo].[GetCommittedFundDetailsByFundTransType]
(
	@projectid int,
	@fundId int,
	@transtype int
)
as
Begin
--exec [GetCommittedFundDetailsByFundTransType] 6637, 209, 241
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
			declare @isReallocation bit
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
				case
					when tr.lkstatus = 262 then sum(det.amount)
					end as CommitmentAmount, 
				--sum(det.Amount) as CommitmentAmount, 
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

			declare @tempAvailFunds table (
				[projectid] [int] NULL,
				[fundid] [int] NULL,
				[lktranstype] [int] NULL,
				[commitmentamount] [money] NULL,	
				[pendingcommitted] [money] NULL,			
				[pendingdisburse] [money] NULL ,
				[finaldisbursedamount] [money] NULL ,
				[provisionalbalance] money null 			
			)
	
			insert into @tempAvailFunds (projectid, fundid, lktranstype, commitmentamount, pendingcommitted, pendingdisburse, finaldisbursedamount, provisionalbalance)
			select projectid, fundid, lktranstype,  
						   sum(isnull( commitmentamount,0)) as commitmentamount,  
						   sum(isnull(pendingamount, 0)) as pendingamount,
						   sum( ISNULL( expendedamount,0)) as expendedamount, 
						   sum( ISNULL( finaldisbursedamount,0)) as finaldisbursedamount,
						
							case when sum(isnull( commitmentamount,0) + isnull( pendingamount,0)) <= 0 then 0  
								 else sum((isnull(commitmentamount,0) + isnull(pendingamount, 0) -(ISNULL( expendedamount, 0) + isnull(finaldisbursedamount,0)))) 
							end as balance
			from @tempFundCommit where fundid = @fundId and lktranstype= @transtype
			group by projectid, fundid,account, lktranstype,FundType, FundName, FundAbbrv, Projnum, ProjectName

			--select * from @tempFundCommit

			select projectid, fundid,lktranstype ,
				case when sum(isnull(commitmentamount,0)) <= 0 then 0 
				else
					(sum(isnull(commitmentamount,0))- ( sum(isnull (pendingdisburse,0))+ sum(isnull(finaldisbursedamount,0)))) 
				end as balance from @tempAvailFunds
			group by projectid, fundid, lktranstype 			
End
go


alter procedure [dbo].[AddStaffAssignment]
(
	@FromProjectId int,
	@ToProjectId int,
	@transDate datetime,		

	@Fromfundid int,	
	@Fromfundtranstype int,
	@Fromfundamount money,

	@Tofundid int,	
	@Tofundtranstype int,
	@Tofundamount money,
	@fromTransId int = null,
	@toTransId int = null, 
	@transGuid varchar(50) = null
)
as
Begin	
	--declare @fromPayeeapplicant int 
	--declare @ToPayeeApplicant int

	--select @fromPayeeapplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname
	--Where  a.finlegal=1 and p.ProjectId = @FromProjectId

	--select @ToPayeeApplicant = a.applicantid from Project p 
	--	join ProjectName pn on pn.ProjectID = p.ProjectId
	--	join ProjectApplicant pa on pa.ProjectId = p.ProjectID	
	--	join Applicant a on a.ApplicantId = pa.ApplicantId	
	--	join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
	--	join AppName an on an.AppNameID = aan.AppNameID 
	--	join LookupValues lv on lv.TypeID = pn.LkProjectname		
	--Where  a.finlegal=1 and p.ProjectId = @ToProjectId

	--if(@toTransId >0)
	--	Begin
	--		insert into Detail (TransId, FundId, LkTransType, Amount)	values
	--				(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
	--		insert into ReallocateLink(fromprojectid, fromtransid, totransid) values
	--				(@FromProjectId, @fromTransId,@toTransId)
	--	End
	--Else
		

		if (@FromProjectId != @ToProjectId)
		Begin
			
			if(@toTransId >0)
			Begin
				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount)

				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
			end
			else
			begin

				--set @Fromfundamount = @Fromfundamount -@Tofundamount

				insert into Trans (ProjectID, date, TransAmt,  LkTransaction, LkStatus, ReallAssignAmt)
					values (@FromProjectId, @transDate, 0, 26552, 261, -@Tofundamount) -- 26552 Board Assignment, 261 Pending
				set @fromTransId = @@IDENTITY;
	
				insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt)
					values (@ToProjectId, @transDate, 0, 26552, 261, @Tofundamount)
				set @toTransId = @@IDENTITY;
				
				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount)

				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)			
				
			end
		end
		else
		Begin

			if(@toTransId >0)
			Begin
				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount)

				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
			end
			else
			begin			
				insert into Trans (ProjectID, date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt)
					values (@FromProjectId, @transDate, 0, 26552, 261, -@Tofundamount) -- 26552 Board Assignment, 261 Pending
				set @fromTransId = @@IDENTITY;
				set @toTransId = @@IDENTITY;

				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@fromTransId, @Fromfundid , @Fromfundtranstype, -@Tofundamount)

				insert into Detail (TransId, FundId, LkTransType, Amount)	values
					(@toTransId, @Tofundid , @Tofundtranstype, @Tofundamount)
			end

		End

		insert into ReallocateLink(fromprojectid, fromtransid, ToProjectId, totransid, ReallocateGUID) values
				(@FromProjectId, @fromTransId, @ToProjectId, @toTransId, @transGuid)
		

		Select @fromTransId as FromTransId, @toTransId as ToTransId
end

go

alter procedure [dbo].[GetFinancialFundDetailsByDateRange]
(
	@startDate datetime,
	@endDate datetime
)
as
Begin
	
	create table #temp
	(
		ProjectId int,
		FundType varchar(50),
		Amount money
	)
	insert into #temp (ProjectId, fundType, amount)
	SELECT   dbo.Project.ProjectId,  dbo.LkFundType.Description AS FundType, 
	sum(case when Trans.LkTransaction IN (238, 239, 240, 26552) then dbo.Detail.Amount else 0 end) - sum(case when Trans.LkTransaction IN (236, 237) then dbo.Detail.Amount else 0 end)
	 as Tot_Amt
                      
	FROM         dbo.LkFundType INNER JOIN
						  dbo.Detail INNER JOIN
						  dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
						  dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
						  dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId ON dbo.LkFundType.TypeId = dbo.Fund.LkFundType INNER JOIN
						  dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID
	WHERE    (trans.Date between @startDate and @endDate) AND Trans.rowisactive=1
			 and LkFundType.rowisactive = 1 and Trans.LkStatus = 262
	GROUP BY  dbo.Project.ProjectId, dbo.LkFundType.Description
	ORDER BY dbo.Project.ProjectId, FundType

	--select * from  #temp

	DECLARE @cols AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX);

	SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.fundType) 
				FROM #temp c
				FOR XML PATH(''), TYPE
				).value('.', 'NVARCHAR(MAX)') 
			,1,1,'')

	set @query = 'SELECT ProjectId, ' + @cols + ' from 
				(
					select ProjectId
						, FundType
						, Amount
					from #temp
			   ) x
				pivot 
				(
					 max(amount)
					for fundtype in (' + @cols + ')
				) p '

	execute(@query)
	drop table #temp
End
go


create procedure [dbo].[GetAssignmentByGuid]
(	
	@fromProjId int
	,@reallocateGuid varchar(50)
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where FromProjectId = @fromProjId and ReallocateGUID = @reallocateGuid
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId  and ReallocateGUID = @reallocateGuid

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	

	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId
		, td. projGuid, t.datemodified
	
	 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.transid
	Where     f.RowIsActive=1 and t.LkTransaction = 26552	
	and t.TransId in(select distinct transid from @temp)
	--and p.ProjectId in (select distinct toprojid from #temp)
	order by d.DateModified desc

End
go

Alter procedure [dbo].[GetAssignmentByTransId]
(	
	@fromProjId int
	--,@toTransId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId
		--right outer join #temp te on te.transid = t.transid
	Where     f.RowIsActive=1 and t.LkTransaction = 26552 and t.lkstatus = 261
	and t.TransId in(select distinct transid from @temp)
	 --and p.ProjectId in (select distinct toprojid from #temp)
	order by d.DateModified desc

End

go


alter  procedure [dbo].[GetAssignmentDetailsNewProjFund]
(	
	@fromProjId int,
	@fundId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 26552	 and t.lkstatus = 261
	and f.fundid = @fundid 
	and t.TransId in(select distinct transid from @temp)
	order by d.DateModified desc
End
go

alter procedure [dbo].GetAssignmentDetailsNewProjFundTransType
(	
	@fromProjId int,
	@fundId int,
	@transTypeId int
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId 
		,td.projguid, t.datemodified
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 26552	 and t.lkstatus = 261
	and f.fundid = @fundid and d.lktranstype = @transTypeId
	and t.TransId in(select distinct transid from @temp)
	
	order by d.DateModified desc

End

go

alter procedure [dbo].[GetCommittedFundByProject]
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
go


alter view vw_FinancialDetailSummary
as
	select  p.projectid, 
				det.FundId,f.account,
				det.lktranstype, 
				ttv.typeid,				
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
				 case when tr.LkTransaction= 236 then  -(det.Amount) else det.Amount end as   detail, 
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
		where tr.LkTransaction in (238,239,240, 236, 237, 26552)and pn.DefName =1 
		and tr.RowIsActive=1 and det.RowIsActive=1 --and p.projectid = @projectid
		
go
