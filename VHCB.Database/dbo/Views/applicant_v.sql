create view dbo.applicant_v as
Select an.AppNameID, an.Applicantname, a.ApplicantID, a.LkEntityType, a.LKEntityType2
from AppName an(nolock)
join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID