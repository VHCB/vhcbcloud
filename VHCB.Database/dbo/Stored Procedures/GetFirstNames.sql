
create procedure GetFirstNames
(
	@FirstNamePrefix varchar(50)
)  
as
--exec GetFirstNames 'rama'
begin

  select top 10 c.Firstname +', '+ c.Lastname +', '+  a.email 
  from applicantcontact ac(nolock)
  join contact c(nolock) on c.ContactId = ac.ContactID
  join Applicant a(nolock) on a.ApplicantId = ac.ApplicantID
  where c.Firstname like @FirstNamePrefix + '%'
  order by c.Firstname asc 
end