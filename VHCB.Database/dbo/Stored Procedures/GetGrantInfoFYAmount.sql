
CREATE procedure GetGrantInfoFYAmount
(
	@GrantInfoId int
)
as
Begin
	select gfy.grantinfofy, gfy.GrantinfoID, gfy.LkYear, gfy.Amount, gfy.RowIsActive, lv.Description 
	from GrantinfoFYAmt gfy join LookupValues lv on lv.TypeID = gfy.LkYear
	where lv.LookupType = (select recordid from LkLookups where tablename = 'LKYear')
	and lv.RowIsActive = 1 and gfy.GrantinfoID = @GrantInfoId
End