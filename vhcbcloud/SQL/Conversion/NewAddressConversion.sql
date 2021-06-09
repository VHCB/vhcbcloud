use vhcb
go

	DECLARE @ProjectId int, @StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State1 as varchar(100), 
	@Zip as varchar(100), @County as varchar(100), @Latitude float, @Longitude float, @PrimaryAdd bit, @Village nvarchar(35)

	declare @UserId int
	set @UserId = 9999

	declare NewCursor Cursor for
	select ProjectID, PrimaryAdd, Street# as StreetNo, Address1, Address2, Town, Village, County, [State] as State1, Zip , Latitude, Longitude
	from AddressConversionSinle

	open NewCursor
	fetch next from NewCursor into @ProjectId, @PrimaryAdd, @StreetNo, @Address1, @Address2, @Town, @Village, @County,  @State1, @Zip, @Latitude, @Longitude
	WHILE @@FETCH_STATUS = 0
	begin

		if exists(select 1 from address a(nolock) where a.Street# = @StreetNo and a.Address1 = @Address1 and a.Town = @Town and a.Zip = @Zip)
		begin
			declare @AddressId int
			select @AddressId = AddressId from address a(nolock) where a.Street# = @StreetNo and a.Address1 = @Address1 and a.Town = @Town and a.Zip = @Zip
			
			-- Update Address
			update address set village = @Village, VillageName = @Village, latitude = @Latitude, Longitude = @Longitude, [State] = @State1, County = @County, UserId = @UserId
			where AddressId = @AddressId

			if exists(select 1 from ProjectAddress a(nolock) where ProjectId = @ProjectId and PrimaryAdd = 1)
			begin
				-- Update ProjectAddress AddressId
				update ProjectAddress set AddressId = @AddressId,  UserId = @UserId where ProjectId = @ProjectId and PrimaryAdd = @PrimaryAdd
			end
			else
			begin 
				-- Insert Existing address for ProjectAddress
				insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd, UserId)
				select @ProjectId, @AddressId, @PrimaryAdd, @UserId
			end
		end
		else
		begin
			declare @AddressId1 int
			insert into Address(LkAddressType, Street#, Address1, Address2, Village, VillageName, latitude, longitude, Town, State, Zip, County, UserId)
			select 26240, @StreetNo, @Address1, @Address2, @Village, @Village, @Latitude, @Longitude, @Town, @State1, @Zip, @County, @UserId

			set @AddressId1 =  SCOPE_IDENTITY()

			if exists(select 1 from ProjectAddress a(nolock) where ProjectId = @ProjectId and PrimaryAdd = 1)
			begin
				-- Update ProjectAddress AddressId
				update ProjectAddress set AddressId = @AddressId1,  UserId = @UserId where ProjectId = @ProjectId and PrimaryAdd = @PrimaryAdd
			end
			else
			begin 
				-- Insert Existing address for ProjectAddress
				insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd, UserId)
				select @ProjectId, @AddressId1, @PrimaryAdd, @UserId
			end

		end 


	FETCH NEXT FROM NewCursor INTO  @ProjectId, @PrimaryAdd, @StreetNo, @Address1, @Address2, @Town, @Village, @County,  @State1, @Zip, @Latitude, @Longitude
	END

Close NewCursor
deallocate NewCursor
go

