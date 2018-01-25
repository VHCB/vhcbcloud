CREATE procedure [dbo].[AddDeCommitmentTransDetails]
(	
	@transid int,
	@fundid int,	
	@fundtranstype int,
	@ProjectID int,
	@fundamount money
)
as

BEGIN 
	DECLARE @guid AS uniqueidentifier
	SET @guid = NEWID()


	insert into Detail (TransId, FundId, LkTransType, ProjectID, Amount, DetailGuId)	values
		(@transid, @fundid , @fundtranstype, @ProjectID, -@fundamount, @guid)

END