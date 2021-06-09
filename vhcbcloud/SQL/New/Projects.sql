use VHCB
go

begin tran

--select * from project
--8333

insert into dbo.Project([Proj_num], [LkProjectType], [LkProgram])
select [PROJECT NUMBER], [LKProjectType], [LKProgram]
from [FFVConvert].[dbo].[NewProject_December]
go
--128

select top 129 * from project order by 1 desc
--8461


--rollback
--commit


----------------------------Project Name -----------------------------------------------------------------------

begin tran

DECLARE @ProjectId as int, @ProjName as varchar(100), @LkProjectname int

declare NewCursor Cursor for
select p.ProjectId, v.[Project Name] as ProjName
from dbo.Project p(nolock)
join [FFVConvert].[dbo].[NewProject_December] v on v.[PROJECT NUMBER] = p.Proj_num


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


--select top 129 * from ProjectName order by 1 desc
--7747
--7875
--commit


----------------------------Project Address -----------------------------------------------------------------------

--Default address
select * from address where addressid = 47

begin tran

insert into dbo.ProjectAddress(ProjectId, AddressId, PrimaryAdd) 
select p.ProjectId, 47, 1
from dbo.Project p(nolock)
join [FFVConvert].[dbo].[NewProject_December] v on v.[PROJECT NUMBER] = p.Proj_num

select top 129 * from Projectaddress order by 1 desc

--commit




