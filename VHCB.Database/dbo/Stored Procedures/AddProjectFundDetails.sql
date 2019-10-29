CREATE procedure [dbo].[AddProjectFundDetails]
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money
)
as

BEGIN 
	DECLARE @guid AS uniqueidentifier
	SET @guid = NEWID()


	insert into Detail (TransId, FundId, LkTransType, Amount, DetailGuId)	values
		(@transid,@fundid , @fundtranstype, @fundamount, @guid)


	insert into Detail (TransId, FundId, LkTransType, LandUsePermitID, Amount, DetailGuId) 
	select top 1 Transid, FundId, LkTransType, LandUsePermitID, -@fundamount, @guid 
	from detail where transid = @transid and amount < 0 

END