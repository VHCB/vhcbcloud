
CREATE  procedure [dbo].[DeleteFund]
(
	@fundId int
)
as
Begin
	declare @grantInfoId int
	if exists (select 1 from fundgrantInfo where fundid = @fundid)
	Begin
		select @grantInfoId = Grantinfoid from FundGrantinfo where fundid = @fundid
		update GrantinfoFYAmt set RowIsActive = 0  where grantinfoid = @GrantInfoId
		update GrantInfo  set RowIsActive = 0   where GrantinfoID = @GrantInfoId
		update FundGrantinfo  set RowIsActive = 0   where GrantinfoID = @GrantInfoId
	End
	Update  Fund  set RowIsActive = 0  where fundid = @fundId
	
End