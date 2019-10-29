
create procedure GetEasementHolder
as
--exec GetEasementHolder
begin
	select a.applicantid, an.ApplicantName 
	from applicant a(nolock)
	join applicantappname aan(nolock) on a.applicantid = aan.applicantid
	join appname an(nolock) on aan.appnameid = an.appnameid
	where a.RowIsActive = 1
	Order by An.ApplicantName	
end