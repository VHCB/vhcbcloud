CREATE procedure GetLastNames
(
	@LastNamePrefix varchar(50)
)  
as
--exec GetLastNames 'na'
begin

  select top 10 c.Lastname + ', '+ c.Firstname +', '+ isnull(c.MI, '') +', '+  isnull(a.email, '') + ', ' + convert(varchar(10), isnull(an.AppNameID, ''))
  from applicantcontact ac(nolock)
  join contact c(nolock) on c.ContactId = ac.ContactID
  join Applicant a(nolock) on a.ApplicantId = ac.ApplicantID
  left join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
  left join appname an(nolock) on an.AppNameID = aan.AppNameID
  where c.Lastname like @LastNamePrefix + '%'
  order by c.Lastname asc 
end