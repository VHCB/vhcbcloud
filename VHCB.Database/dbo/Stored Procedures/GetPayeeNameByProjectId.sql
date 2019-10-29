
CREATE procedure GetPayeeNameByProjectId
(
	@ProjectID int
)
as
begin

	select an.Applicantname, p.LkProgram 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantID = a.ApplicantID
	join project p on p.projectid = pa.ProjectId
	join ProjectName pn(nolock) on p.ProjectId = pn.ProjectID
	where pa.finlegal=1 and pn.defname=1 and pa.projectID = @ProjectID
	order by an.Applicantname
end