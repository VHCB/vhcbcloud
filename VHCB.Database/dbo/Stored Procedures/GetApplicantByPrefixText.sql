CREATE procedure GetApplicantByPrefixText
(
	@ApplicantName varchar(50)
) 
as 
select an.ApplicantName, LKEntityType2 --+ ' ' + convert(varchar(10), an.appnameid) as ApplicantName
from Appname an
join ApplicantAppName aan on aan.appnameid = an.appnameid
join applicant a(nolock) on a.applicantid = aan.ApplicantID
where ApplicantName like @ApplicantName + '%'
order by   an.Applicantname asc