use FFV
go

	--SELECT *
	--INTO Duplicate_ProjectName
	--FROM (
	--select *
	--from [VW_Farminfo for conversion]
	--where[FarmName_Do_NOT_Use] in(
	--select [FarmName_Do_NOT_Use]
	--from [VW_Farminfo for conversion]
	--group by [FarmName_Do_NOT_Use]
	--having count(*) > 1)
	--) t

	--select * from Duplicate_ProjectName

	DECLARE @AddressId int, @ProjectId int, @StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State as varchar(100), 
	@Zip as varchar(100), @County as varchar(100)

	declare NewCursor Cursor for
	select p.projectId, case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then SUBSTRING(Address1, 0,PATINDEX('% %', Address1)) else '' end as 'StreetNo',
	case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then rtrim(ltrim(SUBSTRING(Address1, len(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) + 1, Len(Address1)))) 
	else Address1 end as 'Address1', Address2, Town, State, Zip, County
	from [VW_Farminfo for conversion] v
	join VHCB.dbo.Project p(nolock) on v.[Project #] = p.Proj_num
	where[FarmName_Do_NOT_Use] not in(
	select [FarmName_Do_NOT_Use]
	from [VW_Farminfo for conversion]
	group by [FarmName_Do_NOT_Use]
	having count(*) > 1)


	open NewCursor
	fetch next from NewCursor into @ProjectId, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	WHILE @@FETCH_STATUS = 0
	begin

		insert into VHCB.dbo.Address([Street#], [Address1], [Address2], [Town],[State], [Zip], [County])
		values(@StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County)

		set @AddressId =  SCOPE_IDENTITY()
	
		insert into VHCB.dbo.ProjectAddress(ProjectId, AddressId, PrimaryAdd)
		values(@ProjectId, @AddressId, 1)

	FETCH NEXT FROM NewCursor INTO @ProjectId, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County 
	END

Close NewCursor
deallocate NewCursor
go
