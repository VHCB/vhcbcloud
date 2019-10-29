CREATE procedure [dbo].[AddProjectFundReallocationFromDetail]
(	
	@fundid int,	
	@fundtranstype int,
	@fundamount money
)
as

BEGIN 
	declare @transid int
	select @transid =  d. TransId from detail d join trans t on t.TransId = d.TransId where d.FundId = @fundid
	
	insert into Detail (TransId, FundId, LkTransType, Amount)	values
		(@transid,@fundid , @fundtranstype, -@fundamount)
END