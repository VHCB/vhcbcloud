CREATE procedure PCR_Trans_Detail_Submit
(
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@fundamount money,
	@ProjectId int
)
as
begin

	--12/01
	--insert into Detail (TransId, FundId, LkTransType, Amount)	values
	--	(@transid, @fundid , @fundtranstype, @fundamount)

	--PCR/Disbursement allow only negative amounts.
	insert into Detail (TransId, FundId, LkTransType, Amount, ProjectId)	values
		(@transid, @fundid , @fundtranstype, -@fundamount, @ProjectId)
end