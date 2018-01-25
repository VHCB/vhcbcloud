
CREATE procedure GetFundInfoDetailsByLastModified
(
	@IsActiveOnly	bit = true
)
as
Begin
	select lft.FundId, lft.account, lft.name, lft.abbrv, lv.description, lft.LkFundType, lft.RowIsActive  
	from Fund lft
	join LkFundType lv on lv.typeid = lft.lkfundtype where (@IsActiveOnly = 0 or lft.RowIsActive = @IsActiveOnly)
	order by lft.DateModified desc
	
End