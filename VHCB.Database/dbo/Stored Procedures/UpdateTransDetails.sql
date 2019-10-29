
CREATE procedure [dbo].[UpdateTransDetails]
(	
	@detailId int,	
	@fundtranstype int,
	@fundamount money
)
as
BEGIN 
	
	update Detail set Amount = @fundamount, LkTransType = @fundtranstype
	where DetailID = @detailId
END