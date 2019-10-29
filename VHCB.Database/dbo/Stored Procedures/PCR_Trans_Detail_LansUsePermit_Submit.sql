CREATE procedure PCR_Trans_Detail_LansUsePermit_Submit
(
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money,
	@ProjectID int,
	@LandUsePermit nvarchar(15),
	@LandUseFarmId int
)
as
begin

	--12/01
	--insert into Detail (TransId, FundId, LkTransType, Amount)	values
	--	(@transid, @fundid , @fundtranstype, @fundamount)

	--PCR/Disbursement allow only negative amounts.
	DECLARE @guid AS uniqueidentifier
	SET @guid = NEWID()

	insert into Detail (TransId, FundId, LkTransType, ProjectID, Amount, LandUsePermitid, DetailGuId) values
		(@transid,@fundid, @fundtranstype, @ProjectID, -@fundamount, @LandUseFarmId, @guid)

	--insert into act250devpay (Act250FarmId, AmtRec, DateRec) values
	--		(@LandUseFarmId, @fundAmount, getdate())
end