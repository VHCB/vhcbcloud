
CREATE procedure PCR_ApplicantName
(
	@ProjectID int
)
as
begin

	select an.Applicantname 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	join Applicant a on a.ApplicantId = aan.ApplicantID
	join ProjectApplicant pa on pa.ApplicantID = a.ApplicantID
	where aan.DefName = 1 and pa.LkApplicantRole=358 and projectID = @ProjectID
	order by an.Applicantname
end