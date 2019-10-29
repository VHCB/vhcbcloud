CREATE procedure AddCommitmentTransDetailsWithLandPermit
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@ProjectID	int,
	@fundamount money,
	@LandUsePermit nvarchar(15),
	@LandUseFarmId int
)
as

BEGIN 
	DECLARE @guid AS uniqueidentifier
	SET @guid = NEWID()

	insert into Detail (TransId, FundId, LkTransType, ProjectID, Amount, LandUsePermitid, DetailGuId)	values
		(@transid,@fundid , @fundtranstype, @ProjectID, @fundamount, @LandUseFarmId, @guid)

	--insert into Detail (TransId, FundId, LkTransType, LandUsePermitID, Amount, DetailGuId) 
	--select top 1 Transid, FundId, LkTransType, LandUsePermitID, -@fundamount, @guid from detail where transid = @transid and amount < 0 

	--insert into act250devpay (Act250FarmId, AmtRec, DateRec) values
	--		(@LandUseFarmId, @fundAmount, getdate())
END