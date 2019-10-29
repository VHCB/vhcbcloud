CREATE procedure PCR_Trans_Detail_Load
(
	@transid int
)
as
begin
Select t.projectid, d.detailid, f.FundId, f.account,  format(-d.Amount, 'N2') as PosAmount, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
			d.LkTransType, t.LkTransaction, StateAcctnum +' - '+ isnull(f.DeptID, '') +' - '+ isnull(f.VHCBCode, '') as StateVHCBNos,
			CASE WHEN isnull(d.LandUsePermitID, '') != ''  then f.name + ' - ' + af.UsePermit
				ELSE f.name
				END as FundName
from Fund f 
	join Detail d on d.FundId = f.FundId
	join Trans t on t.TransId = d.TransId
	join LookupValues lv on lv.TypeID = d.LkTransType
	left join stateaccount sa(nolock) on sa.LkTransType = d.LkTransType
	left join Act250Farm af(nolock) on af.Act250FarmId = d.LandUsePermitID
Where     f.RowIsActive = 1 --and t.LkTransaction = @commitmentType
		and t.TransId = @transid 
end