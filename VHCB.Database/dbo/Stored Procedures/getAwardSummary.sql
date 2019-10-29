CREATE procedure [dbo].[getAwardSummary]
(
	@ProjectID as int 
)
as
begin
--getAwardSummary 6586
	declare @tempFundSummary table 
	(
			ProjectId			int null,
			ProjectName			varchar(50) null,
			ProjectNumber		varchar(12) null,
			Account				int null,
			FundId				int null,
			FundName			varchar(50) null,
			FundTransTypeName	varchar(50) null,
			FundTransType		int null,
			LandUsePermitId		int null,
			UsePermit			varchar(50) null,

			FinalCommitmentAmount	money null default(0),
			FinalDecommitmentAmount	money null default(0),
			FinalReallocationAmount	money null default(0),
			FinalAssignmentAmount	money null default(0),
			FinalDisbursementAmount	money null default(0),
			FinalRefundAmount		money null default(0),
			FinalAdjustmentAmount	money null default(0),

			PendingCommitmentAmount	money null default(0),
			PendingDecommitmentAmount	money null default(0),
			PendingReallocationAmount	money null default(0),
			PendingAssignmentAmount	money null default(0),
			PendingDisbursementAmount	money null default(0),
			PendingRefundAmount		money null default(0),
			PendingAdjustmentAmount	money null default(0)
	)

	insert into @tempFundSummary(ProjectId, ProjectName, ProjectNumber, Account, FundId, FundName, FundTransTypeName, FundTransType, LandUsePermitId, UsePermit)
	select p.projectid, lv.Description, p.Proj_num, f.account, d.FundId, f.name, ttv.description, d.lkTransType, isnull(d.LandUsePermitID, ''), isnull(act. UsePermit, '')
	from trans tr(nolock)
	join detail d(nolock) on tr.transid = d.TransId
	join fund f(nolock) on f.fundid = d.fundid
	join Project p(nolock) on p.ProjectId = tr.ProjectID
	join ProjectName pn(nolock) on pn.ProjectID = p.ProjectId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	left join LkTransType_v ttv(nolock) on d.lktranstype = ttv.typeid	
	left join Act250Farm act(nolock) on act.Act250FarmId = isnull(d.LandUsePermitID, '')
	where tr.ProjectID = @ProjectID and tr.LkStatus in (261, 262) and tr.RowIsActive = 1 and d.RowIsActive = 1 and tr.Balanced = 1 and pn.DefName =1
	group by p.projectid, lv.Description, p.Proj_num, f.account, d.FundId, f.name, ttv.description, d.lkTransType, isnull(d.LandUsePermitID, ''), isnull(act. UsePermit, '')

	--select * from @tempFundSummary
	--Final
	update tt set tt.FinalCommitmentAmount = temp.CommitmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) CommitmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where  tr.ProjectID = @ProjectID and tr.LkStatus = 262 and tr.LkTransaction = 238 and tr.Adjust = 0 
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalDecommitmentAmount = temp.DecommitmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) DecommitmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.LkTransaction = 239 and tr.Adjust = 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalReallocationAmount = temp.ReallocationAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) ReallocationAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.LkTransaction = 240 and tr.Adjust = 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalAssignmentAmount = temp.AssignmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) AssignmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.LkTransaction = 26552 and tr.Adjust = 0 --and d.Amount < 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalDisbursementAmount = temp.DisbursementAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) DisbursementAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.LkTransaction = 236 and tr.Adjust = 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalRefundAmount = temp.RefundAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) RefundAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.LkTransaction = 237 and tr.Adjust = 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.FinalAdjustmentAmount = temp.AdjustmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) AdjustmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 262 and tr.Adjust = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	--Pending
	update tt set tt.PendingCommitmentAmount = temp.CommitmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) CommitmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where  tr.ProjectID = @ProjectID and tr.LkStatus = 261 and tr.LkTransaction = 238 and tr.Adjust = 0  and tr.Balanced = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingDecommitmentAmount = temp.DecommitmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) DecommitmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.LkTransaction = 239 and tr.Adjust = 0  and tr.Balanced = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingReallocationAmount = temp.ReallocationAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) ReallocationAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.LkTransaction = 240 and tr.Adjust = 0  and tr.Balanced = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingAssignmentAmount = temp.AssignmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) AssignmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.LkTransaction = 26552 and tr.Adjust = 0  and tr.Balanced = 1 --and d.Amount < 0
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingDisbursementAmount = temp.DisbursementAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) DisbursementAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.LkTransaction = 236 and tr.Adjust = 0  and tr.Balanced = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingRefundAmount = temp.RefundAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) RefundAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.LkTransaction = 237 and tr.Adjust = 0 and tr.Balanced = 1
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	update tt set tt.PendingAdjustmentAmount = temp.AdjustmentAmount
	from @tempFundSummary tt
	join (
		select d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '') LandUsePermitID,
		sum(isnull(d.Amount, 0)) AdjustmentAmount
		from trans tr(nolock)
		join Detail d(nolock) on tr.transid = d.TransId
		join @tempFundSummary t on t.FundId = d.FundId and t.FundTransType = d.LkTransType and isnull(t.LandUsePermitId, '') = isnull(d.LandUsePermitId, '')
		where tr.ProjectID = @ProjectID  and tr.LkStatus = 261 and tr.Adjust = 1  and tr.Balanced = 1 --tr.LkTransaction = 26733 
		group by  d.FundId, d.lkTransType, isnull(d.LandUsePermitID, '')
	) temp on temp.FundId = tt.FundId and temp.LkTransType = tt.FundTransType and temp.LandUsePermitID = tt.LandUsePermitId

	--select * from @tempFundSummary

	select ProjectId, Account, FundId, 
		case when isnull(UsePermit, '') = '' then FundName else FundName + ' - ' + isnull(UsePermit, '') end as FundName, 
		FundTransTypeName, FundTransType, LandUsePermitId, 
		(FinalCommitmentAmount + FinalDecommitmentAmount + FinalReallocationAmount + FinalAssignmentAmount + FinalAdjustmentAmount) as FinalCommited,
		(FinalDisbursementAmount + FinalRefundAmount) as Disbursed,
		(FinalCommitmentAmount + FinalDecommitmentAmount + FinalReallocationAmount + FinalAssignmentAmount + FinalAdjustmentAmount) - abs((FinalDisbursementAmount + FinalRefundAmount)) Balanced,
		(PendingCommitmentAmount + PendingDecommitmentAmount + PendingReallocationAmount + PendingAssignmentAmount + PendingAdjustmentAmount) + (PendingDisbursementAmount + PendingRefundAmount)as Pending
	from @tempFundSummary order by FundId

	select p.Proj_num + ' - ' +	lv.Description  as ProjectName, t.date as TransDate,
		f.Account,
		case when isnull(act.UsePermit, '') = '' then f.name else f.name + ' - ' + isnull(act.UsePermit, '') end as FundName , 
		ttv.description as 'FundType',
		lv2.Description as 'Status', 
		lv1.Description as 'Transaction',  
		d.Amount, 
		0 as IsDifferentProject,
		t.Adjust, d.DetailId
	from trans t(nolock)
	join detail d(nolock) on t.TransId = d.TransId
	join fund f(nolock) on f.FundId = d.FundId
	join Project p(nolock) on p.ProjectId = d.ProjectID
	join ProjectName pn(nolock) on pn.ProjectID = p.ProjectId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	left join LkTransType_v ttv(nolock) on d.lktranstype = ttv.typeid	
	left join Act250Farm act(nolock) on act.Act250FarmId = isnull(d.LandUsePermitID, '')
	left join LookupValues lv1(nolock) on lv1.TypeID = t.LkTransaction
	left join LookupValues lv2(nolock) on lv2.TypeID = t.LkStatus
	where t.ProjectID = @ProjectID  and t.RowIsActive = 1 and d.RowIsActive = 1 and t.Balanced = 1 and pn.DefName =1
	--order by  d.DateModified desc --f.FundId
	union All
	select p.Proj_num + ' - ' +	lv.Description  as ProjectName, t.date as TransDate,
		f.Account,
		case when isnull(act.UsePermit, '') = '' then f.name else f.name + ' - ' + isnull(act.UsePermit, '') end as FundName, 
		ttv.description as 'FundType',
		lv2.Description as 'Status', 
		lv1.Description as 'Transaction',  
		d.Amount, 
		1 as IsDifferentProject,
		t.Adjust,  d.DetailId
	from TransAssign ta(nolock)
	join trans t(nolock) on ta.ToTransID = t.TransId
	join detail d(nolock) on t.TransId = d.TransId
	join fund f(nolock) on f.FundId = d.FundId
	join Project p(nolock) on p.ProjectId = d.ProjectID
	join ProjectName pn(nolock) on pn.ProjectID = p.ProjectId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	left join LkTransType_v ttv(nolock) on d.lktranstype = ttv.typeid	
	left join Act250Farm act(nolock) on act.Act250FarmId = isnull(d.LandUsePermitID, '')
	left join LookupValues lv1(nolock) on lv1.TypeID = t.LkTransaction
	left join LookupValues lv2(nolock) on lv2.TypeID = t.LkStatus
	where ta.TransID in (select TransID from trans(nolock) where ProjectID = @ProjectID and LkTransaction = 26552)
	 and t.RowIsActive = 1 and d.RowIsActive = 1 and t.Balanced = 1 and pn.DefName =1
	--order by  d.DateModified desc


end