CREATE procedure IsDuplicateFundDetailPerTransaction 
(
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@UsePermit nvarchar(10)

)
as
Begin

	--if(@UsePermit != '')
		select * from Detail where TransId = @transid and FundId = @fundid and LkTransType = @fundtranstype and RowIsActive = 1 and isnull(LandUsePermitID, '') = @UsePermit
	--else
		--select * from Detail where TransId = @transid and FundId = @fundid and LkTransType = @fundtranstype and RowIsActive = 1
End