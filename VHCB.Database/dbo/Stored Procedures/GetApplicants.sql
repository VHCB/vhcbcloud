CREATE procedure [dbo].[GetApplicants]

as 

select an.appnameid, an.ApplicantName from Appname an
join ApplicantAppName aan on aan.appnameid = an.appnameid
order by   an.Applicantname asc