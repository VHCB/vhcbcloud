CREATE procedure [dbo].[GetFundDetailsByFundId]
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