CREATE procedure [dbo].[AddBoardFinancialTransaction]
(
	@projectId int,
	@transDate datetime,
	@transAmt money,
	@payeeApplicant int = null,
	@commitmentType varchar(50),
	@lkStatus int,
	@UserId int = null
)
as
Begin
	declare @recordId int
	declare @transTypeId int

	select @recordId = RecordID from LkLookups where Tablename = 'LkTransAction'
	select @transTypeId = TypeID from LookupValues where LookupType = @recordId and Description = @commitmentType
	
	insert into Trans (ProjectID, date, TransAmt, PayeeApplicant, LkTransaction, LkStatus, UserID)
		values (@projectId, @transDate, @transAmt, @payeeApplicant, @transTypeId, @lkStatus, @UserId)

	select tr.TransId, p.projectid, p.Proj_num, tr.Date, format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, 
		tr.PayeeApplicant, tr.LkTransaction 
	from Project p 		
		join Trans tr on tr.ProjectID = p.ProjectId	
		join LookupValues lv on lv.TypeID = tr.LkStatus
	Where  tr.RowIsActive = 1 and tr.TransId = @@IDENTITY; 

end