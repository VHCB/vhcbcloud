
CREATE procedure UpdateContactDOB
(
	@ApplicantId	int,
	@DOB			DateTime
)
--exec UpdateContactDOB 6638
as
begin

update c set c.DOB = @DOB 
	from applicant a(nolock)
	join applicantContact ac(nolock) on ac.ApplicantID =  a.ApplicantId
	join Contact c(nolock) on c.ContactId = ac.ContactID
	join projectapplicant pa(nolock) on pa.applicantid = a.applicantid
	where a.ApplicantId = @ApplicantId
end