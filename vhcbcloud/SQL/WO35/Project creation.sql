use vhcb
go
--Insert Project
begin tran

insert into dbo.Project([Proj_num], [LkProjectType], [LkProgram]) values('1968-200-059', 26711, 146)
select n.[Project #], n.Type, n.Program--, aa.ApplicantID, n.[Project Name]
from NewProjectsforConversion n(nolock)
join appname p(nolock) on n.[Primary Applicant] = P.Applicantname
left join ApplicantAppName aa(nolock) on p.AppNameID = aa.AppNameID

commit
select * from project where DateModified> getdate() - 1 order by 1 desc
--Project Name

begin tran

DECLARE @ProjectId as int, @ProjName as varchar(100), @LkProjectname int
declare NewCursor Cursor for
select p.ProjectId, n.[Project Name] as ProjName
from dbo.Project p(nolock)
join NewProjectsforConversion n(nolock) on n.[Project #] = p.Proj_num
where proj_num = '1968-200-059'

	open NewCursor
	fetch next from NewCursor into @ProjectId, @ProjName 
	WHILE @@FETCH_STATUS = 0
	begin

	insert into dbo.Lookupvalues([LookupType], [Description], [Ordering], [SubReq])
	select 118, @ProjName, 0, 0

	set @LkProjectname =  SCOPE_IDENTITY()

	insert into dbo.ProjectName([ProjectID], [LkProjectname], [DefName])
	select @ProjectId, @LkProjectname, 1

	FETCH NEXT FROM NewCursor INTO @ProjectId, @ProjName 
	END

Close NewCursor
deallocate NewCursor
go

 select * from project_v where proj_num = '1968-200-059'
commit


begin tran

insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal)
select ProjectId, t.ApplicantID, 358, 1, 0
from project p(nolock)
join (select n.[Project #] as projectNum, n.Type, n.Program, aa.ApplicantID, n.[Project Name]
from NewProjectsforConversion n(nolock)
join appname p(nolock) on n.[Primary Applicant] = P.Applicantname
left join ApplicantAppName aa(nolock) on p.AppNameID = aa.AppNameID) t on t.projectNum = p.proj_num

select * from projectApplicant where datemodified > getdate() - 1

commit