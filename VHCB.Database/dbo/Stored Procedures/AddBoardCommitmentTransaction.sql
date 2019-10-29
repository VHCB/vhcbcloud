Create procedure AddBoardCommitmentTransaction
(
	@projectId int,
	@transDate datetime,
	@transAmt money,
	@payeeApplicant int,
	@commitmentType varchar(50),
	@lkStatus int
)
as
Begin
	declare @recordId int
	declare @transTypeId int

	select @recordId = RecordID from LkLookups where Tablename = 'LkTransAction'
	select @transTypeId = TypeID from LookupValues where LookupType = @recordId and Description = @commitmentType
		insert into Trans (ProjectID, date, TransAmt, PayeeApplicant, LkTransaction, LkStatus)
		values (@projectId, @transDate, @transAmt, @payeeApplicant, @transTypeId, @lkStatus)
end