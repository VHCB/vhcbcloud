use vhcb
go

--select * from Address
--select * from lookupvalues where typeid in (select distinct LKaddresstype from Address)


	DECLARE @ProjectId int, @StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State1 as varchar(100), 
	@Zip as varchar(100), @County as varchar(100), @Latitude float, @Longitude float, @PrimaryAdd bit, @Village nvarchar(35)

	declare NewCursor Cursor for
	select ProjectID, PrimaryAdd, Street# as StreetNo, Address1, Address2, Town, Village, County, [State] as State1, [zip Code] as Zip , Latitude, Longitude
	from AddressConversion2

	open NewCursor
	fetch next from NewCursor into @ProjectId, @PrimaryAdd, @StreetNo, @Address1, @Address2, @Town, @Village, @County,  @State1, @Zip, @Latitude, @Longitude
	WHILE @@FETCH_STATUS = 0
	begin

		if exists(select 1 from address a(nolock) where a.Street# = @StreetNo and a.Address1 = @Address1 and a.Town = @Town and a.Zip = @Zip)
		begin
			declare @AddressId int
			select @AddressId = AddressId from address a(nolock) where a.Street# = @StreetNo and a.Address1 = @Address1 and a.Town = @Town and a.Zip = @Zip
			print @AddressId

			insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd)
			select @ProjectId, @AddressId, @PrimaryAdd
		end
		else
		begin
			declare @AddressId1 int
			insert into Address(LkAddressType, Street#, Address1, Address2, Village, VillageName, latitude, longitude, Town, State, Zip, County)
			select 26240, @StreetNo, @Address1, @Address2, @Village, @Village, @Latitude, @Longitude, @Town, @State1, @Zip, @County

			set @AddressId1 =  SCOPE_IDENTITY()

			insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd)
			select @ProjectId, @AddressId1, @PrimaryAdd

		end 


	FETCH NEXT FROM NewCursor INTO  @ProjectId, @PrimaryAdd, @StreetNo, @Address1, @Address2, @Town, @Village, @County,  @State1, @Zip, @Latitude, @Longitude
	END

Close NewCursor
deallocate NewCursor
go

