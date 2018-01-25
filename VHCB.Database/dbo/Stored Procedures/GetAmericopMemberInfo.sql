
CREATE procedure GetAmericopMemberInfo
(
	@ProjectId		int
)
--exec GetAmericopMemberInfo 6638
as
begin
	select  a.email, --isnull(nullif(a.cellphone, ''), isnull(nullif(a.WorkPhone, ''), a.HomePhone)) cellphone, 
	a.cellphone, pa.Applicantid, 
		isnull(c.Firstname, '') + ' ' + isnull(c.MI, '') + isnull(c.Lastname, '') name,
		convert(varchar(10), c.DOB, 101) DOB, c.ContactId
	from applicant a(nolock)
	join applicantContact ac(nolock) on ac.ApplicantID =  a.ApplicantId
	join Contact c(nolock) on c.ContactId = ac.ContactID
	--join ApplicantAppName aan(nolock) on aan.ApplicantID = a.ApplicantId
	--join AppName an(nolock) on an.AppNameID = aan.AppNameID
	join projectapplicant pa(nolock) on pa.applicantid = a.applicantid
	where pa.LkApplicantRole =  26294 --Americorps Member
		and pa.RowIsActive = 1 
		and pa.ProjectId = @ProjectId
end