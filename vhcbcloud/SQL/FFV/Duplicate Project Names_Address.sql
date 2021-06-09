use FFV
go


	DECLARE @AddressId int, @ProjectId int, @StreetNo as varchar(50), @NewAddress1 as varchar(100), @Address1 as varchar(100), 
	@Address2 as varchar(100), @Town as varchar(100), @State as varchar(100), 
	@Zip as varchar(100), @County as varchar(100)

	declare NewCursor Cursor for
	select distinct 
	case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then SUBSTRING(Address1, 0,PATINDEX('% %', Address1)) else '' end as 'StreetNo',
	case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then rtrim(ltrim(SUBSTRING(Address1, len(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) + 1, Len(Address1)))) 
	else Address1 end as 'nNwAddress1',
	Address1, Address2, Town, State, Zip, County from [dbo].[Duplicate_ProjectName]


	open NewCursor
	fetch next from NewCursor into @StreetNo, @NewAddress1, @Address1, @Address2, @Town, @State, @Zip, @County
	WHILE @@FETCH_STATUS = 0
	begin

		insert into VHCB.dbo.Address([Street#], [Address1], [Address2], [Town],[State], [Zip], [County])
		values(@StreetNo, @NewAddress1, @Address2, @Town, @State, @Zip, @County)

		set @AddressId =  SCOPE_IDENTITY()
	
		insert into VHCB.dbo.ProjectAddress(ProjectId, AddressId, PrimaryAdd)
		select p.ProjectId, @AddressId, 1
		from [dbo].[Duplicate_ProjectName] dp
		join VHCB.dbo.Project p(nolock) on dp.[Project #] = p.Proj_num
		where [Address1] = @NewAddress1 and [Town] = @Town and [State] = @State and [Zip] = @Zip and [County] = @County

	FETCH NEXT FROM NewCursor INTO  @StreetNo, @NewAddress1, @Address1, @Address2, @Town, @State, @Zip, @County 
	END

Close NewCursor
deallocate NewCursor
go
