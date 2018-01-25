CREATE Procedure [dbo].[GetBoardCommitmentTrans]
(
	@projectId int,
	@commitmentType varchar(50)
)
as
set nocount on
Begin

declare @recordId int
declare @transTypeId int

select @recordId = RecordID from LkLookups where Tablename = 'LkTransAction'
select @transTypeId = TypeID from LookupValues where LookupType = @recordId and Description = @commitmentType

select tr.TransId, p.projectid, p.Proj_num, tr.Date,format(tr.TransAmt, 'N2') as TransAmt, tr.LkStatus, lv.description, tr.PayeeApplicant, tr.LkTransaction from Project p 		
		join Trans tr on tr.ProjectID = p.ProjectId	
		join Applicant a on a.applicantid = tr.payeeapplicant
		join LookupValues lv on lv.TypeID = tr.LkStatus
	Where p.ProjectId = @projectId and tr.LkTransaction = @transTypeId
end