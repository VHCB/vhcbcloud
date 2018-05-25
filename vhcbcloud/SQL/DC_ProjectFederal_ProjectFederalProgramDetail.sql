use PTConvert
go

truncate table VHCB.dbo.ProjectFederalProgramDetail
go

truncate table VHCB.dbo.projectFederal
go

DECLARE @ProjectId as int, @ProjectFederalId as int

declare NewCursor Cursor for
select mp. [ProjectId]
from [dbo].[pthousingproj] pthproj(nolock)
join [dbo].[MasterProj] mp(nolock) on pthproj.[key] = mp.[key]
where hchdo  = 1

open NewCursor
fetch next from NewCursor into @ProjectId
WHILE @@FETCH_STATUS = 0
begin

	insert into VHCB.dbo.projectFederal(LkFedProg, ProjectID, NumUnits)
	values(481, @ProjectId, 0)

	set @ProjectFederalId =  SCOPE_IDENTITY()

	insert into VHCB.dbo.ProjectFederalProgramDetail([ProjectFederalId], [CHDO])
	values(@ProjectFederalId, 1)
FETCH NEXT FROM NewCursor INTO @ProjectId
END

Close NewCursor
deallocate NewCursor
go

  select * from VHCB.dbo.ProjectFederalProgramDetail
  go
  select * from VHCB.dbo.projectFederal
  go