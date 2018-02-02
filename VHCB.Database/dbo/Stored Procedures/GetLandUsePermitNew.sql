CREATE procedure GetLandUsePermitNew
 (
	@ProjectId	int,
	@AccountId		VARCHAR(10),
	@FundTransType int
 )
as
begin
--exec GetLandUsePermitNew 6586, '274', 242

	declare @FundId int

	select @FundId = FundId from Fund(nolock) where account = @AccountId

	select distinct af.UsePermit, af.Act250FarmId
	from Trans t(nolock)
	join detail d (nolock) on t.TransId = d.TransId
	join Act250Farm af(nolock) on d.LandUsePermitID = af.Act250FarmID
	where af.RowIsActive = 1 and d.RowIsActive = 1 and t.RowIsActive = 1 and t.LkTransaction = 238 --Commitment
	and t.projectid = @ProjectId  and d.FundId = @FundId and d.LkTransType = @FundTransType
end