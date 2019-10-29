CREATE procedure [dbo].[UpdateTransDetailsWithFund]
(	
	@detailId int,	
	@fundtranstype int,
	@fundamount money,
	@fundId int,
	@useFarmId nvarchar(25) = null
)
as
BEGIN 

	DECLARE @guid AS uniqueidentifier

	select @guid = DetailGuId from Detail where DetailID = @detailId;

	update Detail set Amount = @fundamount, LkTransType = @fundtranstype, FundId = @fundId, LandUsePermitID = @useFarmId
	where DetailID = @detailId

	update Detail set amount = -@fundamount where DetailID != @detailId and DetailGuId = @guid
END