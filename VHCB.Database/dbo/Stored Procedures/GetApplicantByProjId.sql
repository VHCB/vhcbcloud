CREATE procedure [dbo].[GetApplicantByProjId]
(
	@projId int
)
as
Begin
	Select an.ApplicantName, an.AppNameID from AppName an
	join ApplicantAppName aan on aan.appnameid = an.appnameid
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantId = a.ApplicantId
	join Project p on p.ProjectId = pa.ProjectId
	where a.FinLegal=1 and p.ProjectId = @projId
End