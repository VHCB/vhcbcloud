use VHCBSandbox
go

create procedure PCR_Projects
as
begin
	select project_id, proj_num, project_name,  convert(varchar(25), project_id) +'|' + project_name as project_id_name
	from project_v where project_id in(
			select distinct ProjectId  from [dbo].[ProjectCheckReq]
			union
			select distinct ProjectId from [dbo].[Trans])
	order by proj_num
end
go

create procedure PCR_Dates
as
begin
	select distinct convert(varchar(10), InitDate) as Date  from [dbo].[ProjectCheckReq]
	union
	select distinct convert(varchar(10), Date) as Date from [dbo].[Trans]
	order by Date
end
go

create procedure PCR_ApplicantName
as
begin
	select an.Applicantname 
	from [dbo].[AppName] an(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on an.AppNameID = aan.AppNameID
	where aan.DefName = 1
	order by an.Applicantname
end
go

create procedure PCR_Payee
as
begin
	select an.Applicantname  
	from applicant a(nolock)
	join [dbo].[ApplicantAppName] aan(nolock) on a.applicantid = aan.applicantid
	join [dbo].[AppName] an(nolock) on aan.AppNameID = an.AppNameID
	where a.FinLegal = 1
	order by an.Applicantname
end
go


create procedure PCR_Program
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkProgram')
		and RowIsActive = 1
	order by TypeID
end
go

create procedure PCR_MatchingGrant
as
begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = 73
		and RowIsActive = 1
	order by TypeID
end
go

--select * from [dbo].[LkLookups] where recordid = 34
--select * from [dbo].[Lkstatus_v]LkProgram

--sp_helptext Lkstatus_v

