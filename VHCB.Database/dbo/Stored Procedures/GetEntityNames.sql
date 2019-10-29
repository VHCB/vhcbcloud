
create procedure GetEntityNames
(
	@EntityNamePrefix varchar(50)
)  
as
--exec GetEntityNames 'ab'
begin

	select top 20 an.ApplicantName
	from Appname an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join applicant a(nolock) on a.applicantid = aan.ApplicantID
	join LookupValues lv(nolock) on lv.TypeID = a.LKEntityType2
	where lv.Description = 'Organization' and an.Applicantname like @EntityNamePrefix + '%'
	order by an.Applicantname asc 

 
end