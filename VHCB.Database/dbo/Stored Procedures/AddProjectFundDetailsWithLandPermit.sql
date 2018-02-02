CREATE procedure [dbo].AddProjectFundDetailsWithLandPermit
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money,
	@LandUsePermit nvarchar(15),
	@LandUseFarmId int,
	@ProjectId int
)
as

BEGIN 
	DECLARE @guid AS uniqueidentifier
	SET @guid = NEWID()

	insert into Detail (ProjectID, TransId, FundId, LkTransType, Amount, LandUsePermitid, DetailGuId)	values
		(@ProjectId, @transid, @fundid, @fundtranstype, @fundamount, @LandUseFarmId, @guid)

	insert into Detail (ProjectID, TransId, FundId, LkTransType, LandUsePermitID, Amount, DetailGuId) 
	select top 1 ProjectID, Transid, FundId, LkTransType, LandUsePermitID, -@fundamount, @guid from detail where transid = @transid and amount < 0 

	insert into act250devpay (Act250FarmId, AmtRec, DateRec) values
			(@LandUseFarmId, @fundAmount, getdate())
END