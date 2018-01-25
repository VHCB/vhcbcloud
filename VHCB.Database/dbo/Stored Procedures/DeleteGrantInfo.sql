
CREATE procedure [dbo].[DeleteGrantInfo]
(
	@GrantInfoId int
)
as
Begin
	
	update GrantinfoFYAmt set RowIsActive = 0   where grantinfoid = @GrantInfoId
	update GrantInfo set RowIsActive = 0   where GrantinfoID = @GrantInfoId
	update FundGrantinfo set RowIsActive = 0   where GrantinfoID = @GrantInfoId
	
End