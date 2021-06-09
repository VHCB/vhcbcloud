use VHCB
go

DECLARE @ProjectId as int, @ProjName as varchar(100), @LkProjectname int

declare NewCursor Cursor for
select p.ProjectId, v.[Project Name] as ProjName
from dbo.Project p(nolock)
join dbo.Final_Viab_Conversion v on v.[Project #] = p.Proj_num


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
