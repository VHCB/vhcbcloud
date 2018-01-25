CREATE  procedure [dbo].[ActivateFund]
(
	@fundId int
)
as
Begin
	declare @grantInfoId int
	if exists (select 1 from fundgrantInfo where fundid = @fundid)
	Begin
		select @grantInfoId = Grantinfoid from FundGrantinfo where fundid = @fundid
		update GrantinfoFYAmt set RowIsActive = 1  where grantinfoid = @GrantInfoId and RowIsActive = 0
		update GrantInfo  set RowIsActive = 1   where GrantinfoID = @GrantInfoId and RowIsActive = 0
		update FundGrantinfo  set RowIsActive = 1   where GrantinfoID = @GrantInfoId and RowIsActive = 0
	End
	Update  Fund  set RowIsActive = 1  where fundid = @fundId and RowIsActive = 0
	
End