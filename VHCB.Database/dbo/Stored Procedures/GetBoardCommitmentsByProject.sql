
CREATE Procedure [dbo].[GetBoardCommitmentsByProject]
(
	@projectId int
)
as
set nocount on
Begin
select p.projectid, 
		p.Proj_num, lv.Description, an.Applicantname from Project p 
		join ProjectName pn on pn.ProjectID = p.ProjectId
		join ProjectApplicant pa on pa.ProjectId = p.ProjectID		
		join ApplicantAppName aan on aan.ApplicantID = pa.ApplicantId
		join AppName an on an.AppNameID = aan.AppNameID 
		join LookupValues lv on lv.TypeID = pn.LkProjectname		
	Where pa.Defapp = 1 and p.ProjectId = @projectId
end