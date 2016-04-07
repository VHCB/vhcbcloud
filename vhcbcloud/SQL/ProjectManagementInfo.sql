use vhcbsandbox
go

--select * from project order by DateModified desc 

declare @ProjectId int
declare @TypeId int 

set @ProjectId = 6588

select * from project where ProjectId = @ProjectId

select @TypeId = LkProjectname from ProjectName  where ProjectId = @ProjectId
select * from ProjectName  where ProjectId = @ProjectId
select * from LookupValues where TypeId = @TypeId
select * from ProjectApplicant where ProjectId = @ProjectId

Select an.*
from AppName an(nolock)
join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
where a.ApplicantId in( select ApplicantId from ProjectApplicant where ProjectId = @ProjectId)

