
CREATE procedure PCR_Payee
as
begin
	select an.Applicantname, a.ApplicantId
	from applicant a(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on a.applicantid = aan.applicantid
	join [dbo].[AppName] an(nolock) on aan.AppNameID = an.AppNameID
	where a.FinLegal = 1
	order by an.Applicantname
end