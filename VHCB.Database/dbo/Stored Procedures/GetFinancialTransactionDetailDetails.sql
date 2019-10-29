CREATE procedure GetFinancialTransactionDetailDetails
(
	@transId	int
	
)
as
--exec GetFinancialTransactionDetailDetails 1574
begin

	declare @LKTransaction int 
	select @LKTransaction = LKTransaction from Trans where transid = @transId

	if(@LKTransaction != 26552)
	begin
	select   
			p.proj_num as ProjectNum, det.DetailID, det.FundId, fund.name, det.LkTransType, transtype.description, det.Amount,
			case when isnull(act.UsePermit, '') = '' then fund.name else fund.name + ' - ' + isnull(act.UsePermit, '') end as FundName
		from Trans trans(nolock)
			join detail det(nolock) on trans.TransId = det.TransId
			join fund fund(nolock) on det.fundid = fund.fundid
			join project_v p(nolock) on det.Projectid = p.project_id
			join transtype_v transtype(nolock) on det.LKTransType = transtype.typeid
			left join Act250Farm act(nolock) on act.Act250FarmId = isnull(det.LandUsePermitID, '')
		where trans.TransId = @transId and  p.defname = 1 and trans.RowIsActive = 1 and det.RowIsActive = 1
	end
	else
	begin
		select p.proj_num as ProjectNum, d.DetailID, d.FundId, f.name, d.LkTransType, transtype.description, d.Amount,
		case when isnull(act.UsePermit, '') = '' then f.name else f.name + ' - ' + isnull(act.UsePermit, '') end as FundName
		from TransAssign ta(nolock)
		join Trans t(nolock) on ta.ToTransID = t.TransId
		join Detail d(nolock) on t.transid = d.transid
		join project_v p on p.project_id = d.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join fund f on d.FundId = f.FundId
		join transtype_v transtype(nolock) on d.LKTransType = transtype.typeid
		left join Act250Farm act(nolock) on act.Act250FarmId = isnull(d.LandUsePermitID, '')
		where ta.TransID =  @TransID and  p.defname = 1 and t.RowIsActive = 1 and d.RowIsActive = 1
		order by d.DateModified desc
	end
end