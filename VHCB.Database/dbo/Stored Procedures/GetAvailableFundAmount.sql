CREATE procedure GetAvailableFundAmount
(
	@projectid			int,
	@fundId				int,
	@fundTransType		int,
	@LandUsePermitID	int = null
)
as
Begin
--GetAvailableFundAmount 6586, null, null, null
--GetAvailableFundAmount 6586, 148, null, null
--GetAvailableFundAmount 6586, 148, 243, 9
--GetAvailableFundAmount 6586, 148, 243, 9
--GetAvailableFundAmount 6586, 151, 243, null
--GetAvailableFundAmount 6586, 151, null, null
	declare @tempFundSummary table 
	(
			ProjectId			int null,
			ProjectName			varchar(50) null,
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

	insert into @tempFundSummary(ProjectId, ProjectName, Account, FundId, FundName, FundTransTypeName, FundTransType, LandUsePermitId, UsePermit)
	select p.projectid, lv.Description, f.account, d.FundId, f.name, ttv.description, d.lkTransType, isnull(d.LandUsePermitID, ''), isnull(act. UsePermit, '')
	from trans tr(nolock)
	join detail d(nolock) on tr.transid = d.TransId
	join fund f(nolock) on f.fundid = d.fundid
	join Project p(nolock) on p.ProjectId = tr.ProjectID
	join ProjectName pn(nolock) on pn.ProjectID = p.ProjectId	
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	left join LkTransType_v ttv(nolock) on d.lktranstype = ttv.typeid	
	left join Act250Farm act(nolock) on act.Act250FarmId = isnull(d.LandUsePermitID, '')
	where tr.ProjectID = @ProjectID and tr.LkStatus in (261, 262) and tr.RowIsActive = 1 and d.RowIsActive = 1 and tr.Balanced = 1 and pn.DefName =1
	group by p.projectid, lv.Description, f.account, d.FundId, f.name, ttv.description, d.lkTransType, isnull(d.LandUsePermitID, ''), isnull(act. UsePermit, '')


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

	select ProjectId, Account, FundId, FundName, UsePermit, FundTransTypeName, FundTransType, LandUsePermitId, UsePermit,
		(FinalCommitmentAmount + FinalDecommitmentAmount + FinalReallocationAmount + FinalAssignmentAmount + FinalAdjustmentAmount) as FinalCommited,
		(FinalDisbursementAmount + FinalRefundAmount) as Disbursed,
		(FinalCommitmentAmount + FinalDecommitmentAmount + FinalReallocationAmount + FinalAssignmentAmount + FinalAdjustmentAmount) - abs((FinalDisbursementAmount + FinalRefundAmount)) Balanced,
		(PendingCommitmentAmount + PendingDecommitmentAmount + PendingReallocationAmount + PendingAssignmentAmount + PendingAdjustmentAmount) + (PendingDisbursementAmount + PendingRefundAmount)as Pending
	from @tempFundSummary 
	where ProjectId = @projectid 
	and (@fundId is null or FundId = @fundId)
	and (@fundTransType is null or FundTransType = @fundTransType)
	and (@LandUsePermitID is null or LandUsePermitID = @LandUsePermitID)

end