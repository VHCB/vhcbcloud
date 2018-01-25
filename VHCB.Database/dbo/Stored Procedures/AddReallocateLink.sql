create procedure AddReallocateLink
(
	@fromFundId int,
	@toFundId int
)
as
Begin

	declare @fromTransId int
	declare @toTransId int
	select @fromFundId =  d. TransId from detail d join trans t on t.TransId = d.TransId where d.FundId = @fromFundId
	select @toFundId =  d. TransId from detail d join trans t on t.TransId = d.TransId where d.FundId = @toFundId

	insert into ReallocateLink(fromtransid, totransid) values
			(@fromTransId,@toTransId)
End