
CREATE procedure [dbo].UpdateBoardCommitmentTransaction
(
	@transId int,
	@transDate datetime,
	@transAmt money,	
	@commitmentType varchar(50),
	@lkStatus int
)
as
Begin
	declare @recordId int
	declare @transTypeId int

	select @recordId = RecordID from LkLookups where Tablename = 'LkTransAction'
	select @transTypeId = TypeID from LookupValues where LookupType = @recordId and Description = @commitmentType
		
	update Trans set date = @transDate, TransAmt =@transAmt, LkStatus = @lkStatus
	where TransId = @transId
end