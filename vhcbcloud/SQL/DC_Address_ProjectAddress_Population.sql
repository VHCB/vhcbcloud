use PTConvert
go

DECLARE @AddressId int, @ProjectId int, @town nvarchar(255), @county nvarchar(255)

declare NewCursor Cursor for
	select  p.ProjectId, town, county 
	from towncounty_v v
	join VHCB.dbo.Project p(nolock) on v.ProjNum = p.Proj_num
	left join VHCB.dbo.ProjectAddress pa(nolock) on p.ProjectId = pa.ProjectId
	where pa.ProjectId is null

open NewCursor
	fetch next from NewCursor into @ProjectId, @town, @county
	WHILE @@FETCH_STATUS = 0
	begin

		insert into VHCB.dbo.Address(Town, County)
		values(@town, @county)

		set @AddressId =  SCOPE_IDENTITY()
	
		insert into VHCB.dbo.ProjectAddress(ProjectId, AddressId)
		values(@ProjectId, @AddressId)

	FETCH NEXT FROM NewCursor INTO @ProjectId, @town, @county
	END

Close NewCursor
deallocate NewCursor