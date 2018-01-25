
CREATE procedure [dbo].[UpdateReallocationTransDetails]
(	
	@detailId int,	
	@FromProjId int,
	@fundamount money
)
as
BEGIN 
	declare @transId int
	declare @fromTransId int
	declare @toTransId int
	declare @existingAmt decimal
	declare @offsetDetailId int

	select @transId = transid from Detail where DetailID = @detailId
	select @existingAmt = amount from detail where DetailID = @detailId
	select @offsetDetailId = detailid from detail where transid = @transId and Amount = -@existingAmt

	
	
	update Detail set Amount = -@fundamount 
	where DetailID = @offsetDetailId and TransId = @transId

	update Detail set Amount = @fundamount 
	where DetailID = @detailId and TransId = @transid 
END