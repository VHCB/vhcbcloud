use VHCB
go



	DECLARE @HousingTypeID as int, @HousingID as int, @LkHouseType int, @Units int 

	declare NewCursor Cursor for
	select HousingTypeID, HousingID, LkHouseType, Units from [dbo].[ProjectHouseSubType] where LkHouseType = 170

	declare @Count as int
	set @Count = 0

	open NewCursor
	fetch next from NewCursor into @HousingTypeID, @HousingID, @LkHouseType, @Units
	WHILE @@FETCH_STATUS = 0
	begin

	

	if exists
    (
		select 1
		from projecthousesubtype where HousingID = @HousingID and LkHouseType = 165
    )
	begin

	--select @Count = @Count + 1
	

		update projecthousesubtype set Units = Units + @Units where HousingID = @HousingID and LkHouseType = 165
		
		insert into ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits)
		select @HousingID, 187, @Units

		delete from ProjectHouseSubType where HousingTypeID = @HousingTypeID
	 
	end

	FETCH NEXT FROM NewCursor INTO @HousingTypeID, @HousingID, @LkHouseType, @Units
	END

Close NewCursor
deallocate NewCursor

--print @Count
