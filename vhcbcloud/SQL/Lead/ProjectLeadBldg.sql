use PTConvert
go


--delete pa from projectaddress pa(nolock)
--join address a(nolock) on pa.addressid = a.addressid
--where a.addressid > 6559

--delete from address from address where addressid > 6559

--delete ProjectLeadBldg from ProjectLeadBldg where LeadBldgid >  2

--truncate table  ProjectLeadUnit

--truncate table ProjectLeadMilestone

DECLARE @ProjectId as int, @LeadBldgId int, @AddressId int, @StreetNo as varchar(50), @Address1 as varchar(100), @City as varchar(100), 
	 @Zip as varchar(100), @TypeCode int, @BldgAgeCode int, @Street varchar(250)

declare NewCursor Cursor for
select distinct mp2.[ProjectId], [Type Code] as TypeCode, [Bldg Age Code] as BldgAgeCode,
case when ISNUMERIC(SUBSTRING(Street, 0,PATINDEX('% %', Street))) = 1 then SUBSTRING(Street, 0,PATINDEX('% %', Street)) else '' end as 'StreetNo',
	case when ISNUMERIC(SUBSTRING(Street, 0,PATINDEX('% %', Street))) = 1 then rtrim(ltrim(SUBSTRING(Street, len(SUBSTRING(Street, 0, PATINDEX('% %', Street))) + 1, Len(Street)))) 
	else Street end as 'Address1',
	[City], ld.[Zip], Street
from [dbo].[Lead_Data] ld(nolock)
join [dbo].[MasterProj_2] mp2(nolock) on ld.[Project#] = mp2.[Proj_num]
order by   mp2.[ProjectId]

	open NewCursor
	fetch next from NewCursor into @ProjectId, @TypeCode, @BldgAgeCode, @StreetNo, @Address1, @City, @Zip, @Street
	WHILE @@FETCH_STATUS = 0
	begin

	--delete from VHCB.DBO.ProjectAddress WHERE [ProjectId] = @ProjectId
	
	insert into VHCB.dbo.Address([Street#], [Address1], [Town],  [Zip])
	values(@StreetNo, @Address1, @City, @Zip)

	set @AddressId =  SCOPE_IDENTITY()
	
	IF EXISTS(select * from VHCB.dbo.ProjectAddress where ProjectID =  @ProjectId)
	begin
		update VHCB.dbo.ProjectAddress set PrimaryAdd = 0 where ProjectId= @ProjectId
	end

	insert into VHCB.dbo.ProjectAddress(ProjectId, AddressId, PrimaryAdd)
	values(@ProjectId, @AddressId, 1)

	IF EXISTS(select * from VHCB.dbo.ProjectLeadBldg where ProjectID =  @ProjectId)
	begin
		declare @Building int
		select @Building = max(isnull(Building, 0)) from VHCB.dbo.ProjectLeadBldg where ProjectID =  @ProjectId 

		insert into VHCB.dbo.ProjectLeadBldg([ProjectID], [Building], [AddressID], [Age], [Type], [LHCUnits])
		values(@ProjectId, @Building + 1, @AddressId, @BldgAgeCode, @TypeCode, 1)

		set @LeadBldgId =  SCOPE_IDENTITY()
	end 
	else
	begin
		insert into VHCB.dbo.ProjectLeadBldg([ProjectID], [Building], [AddressID], [Age], [Type], [LHCUnits])
		values(@ProjectId, 1, @AddressId, @BldgAgeCode, @TypeCode, 1)

		set @LeadBldgId =  SCOPE_IDENTITY()
	end

	declare @Unit int
	declare @LeadUnitID int

	declare NewCursor1 Cursor for
	select Unit 
	from [dbo].[Lead_Data] ld(nolock)
	join [dbo].[MasterProj_2] mp2(nolock) on ld.[Project#] = mp2.[Proj_num]
	where mp2.ProjectId = @ProjectId and ld.Street = @Street

	open NewCursor1
	fetch next from NewCursor1 into @Unit
	WHILE @@FETCH_STATUS = 0
	begin

	insert into VHCB.DBO.[ProjectLeadUnit]([LeadBldgID], [Unit])
	select @LeadBldgId, @Unit

	set @LeadUnitID =  SCOPE_IDENTITY()

	insert into VHCB.DBO.ProjectLeadMilestone([ProjectID], [LKMilestone], [LeadBldgID], [LeadUnitID],[MSDate])
	select mp2.ProjectId,
	[Status Code] as LKMilestone, 
	@LeadBldgId, @LeadUnitID,
	getdate() as MSDate
	from [dbo].[Lead_Data] ld(nolock)
	join [dbo].[MasterProj_2] mp2(nolock) on ld.[Project#] = mp2.[Proj_num]
	where mp2.ProjectId = @ProjectId and ld.Street = @Street and Unit = @Unit
	order by mp2.ProjectId

	insert into VHCB.DBO.ProjectLeadMilestone([ProjectID], [LKMilestone], [LeadBldgID], [LeadUnitID],[MSDate])
	select mp2.ProjectId,
	'28689' as LKMilestone, 
	@LeadBldgId, @LeadUnitID,
	[App Date] as MSDate
	from [dbo].[Lead_Data] ld(nolock)
	join [dbo].[MasterProj_2] mp2(nolock) on ld.[Project#] = mp2.[Proj_num]
	where mp2.ProjectId = @ProjectId and ld.Street = @Street and Unit = @Unit and [App Date] is not null
	order by mp2.ProjectId

	insert into VHCB.DBO.ProjectLeadMilestone([ProjectID], [LKMilestone], [LeadBldgID], [LeadUnitID],[MSDate])
	select mp2.ProjectId,
	'28690 ' as LKMilestone, 
	@LeadBldgId, @LeadUnitID,
	[Clear Date] as MSDate
	from [dbo].[Lead_Data] ld(nolock)
	join [dbo].[MasterProj_2] mp2(nolock) on ld.[Project#] = mp2.[Proj_num]
	where mp2.ProjectId = @ProjectId and ld.Street = @Street and Unit = @Unit and [Clear Date] is not null
	order by mp2.ProjectId

	FETCH NEXT FROM NewCursor1 INTO @Unit
	END

	Close NewCursor1
	deallocate NewCursor1

	FETCH NEXT FROM NewCursor INTO @ProjectId, @TypeCode, @BldgAgeCode, @StreetNo, @Address1, @City, @Zip, @Street
	END

Close NewCursor
deallocate NewCursor
go
