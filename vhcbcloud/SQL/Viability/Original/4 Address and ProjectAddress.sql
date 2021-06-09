use vhcb
go

--select * from Address
--select * from lookupvalues where typeid in (select distinct LKaddresstype from Address)


	DECLARE @AddressId int, @ProjectId int, @StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State as varchar(100), 
	@Zip as varchar(100), @County as varchar(100)

	declare NewCursor Cursor for
	select p.projectId, case when ISNUMERIC(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) = 1 then SUBSTRING(Address1, 0,PATINDEX('% %', Address1)) else '' end as 'StreetNo',
	case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then rtrim(ltrim(SUBSTRING(Address1, len(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) + 1, Len(Address1)))) 
	else Address1 end as 'Address1', Address2, Town, State, Zip, County
	from dbo.Project p(nolock)
	join dbo.Final_Viab_Conversion v on v.[Project #] = p.Proj_num

	open NewCursor
	fetch next from NewCursor into @ProjectId, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	WHILE @@FETCH_STATUS = 0
	begin

		insert into dbo.Address(LKaddresstype, [Street#], [Address1], [Address2], [Town],[State], [Zip], [County])
		values(26241, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County)

		set @AddressId =  SCOPE_IDENTITY()
	
		insert into dbo.ProjectAddress(ProjectId, AddressId, PrimaryAdd)
		values(@ProjectId, @AddressId, 1)

	FETCH NEXT FROM NewCursor INTO @ProjectId, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County 
	END

Close NewCursor
deallocate NewCursor
go

