use FFV
go

DECLARE @ProjectId as int, @ProjName as varchar(100), @LkProjectname int

declare NewCursor Cursor for
select p.ProjectId, [FarmRound - Use as Project Name]]] as ProjName
from VHCB.dbo.Project p(nolock)
join [VW_Farminfo for conversion] v on v.[Project #] = p.Proj_num


	open NewCursor
	fetch next from NewCursor into @ProjectId, @ProjName 
	WHILE @@FETCH_STATUS = 0
	begin

	insert into VHCb.dbo.Lookupvalues([LookupType], [Description], [Ordering], [SubReq])
	select 118, @ProjName, 0, 0

	set @LkProjectname =  SCOPE_IDENTITY()

	insert into VHCB.dbo.ProjectName([ProjectID], [LkProjectname], [DefName])
	select @ProjectId, @LkProjectname, 1

	FETCH NEXT FROM NewCursor INTO @ProjectId, @ProjName 
	END

Close NewCursor
deallocate NewCursor
go


--select p.ProjectId, [FarmRound - Use as Project Name]]] 
--from VHCB.dbo.Project p(nolock)
--join [VW_Farminfo for conversion] v on v.[Project #] = p.Proj_num

--select * from VHCB.dbo.ProjectName
----7249
--select 8195 - 7249
----946
--select * from [VW_Farminfo for conversion]
----946
--select * from VHCb.dbo.Lookupvalues where LookupType = 118
----7246
--select 8192-7246
----946