DECLARE @OrganizationName nvarchar(250)

declare NewCursor Cursor for
select[Enity Name] as OrganizationName
from dbo.New_Entities where [Enity Name] is not null
--and [Enity Name] = 'Stimson and Graves Housing Limited Partnership (f/k/a - Waterbury Housing Limited Partnership)'
order by [Enity Name]
	

	open NewCursor
	fetch next from NewCursor into @OrganizationName
	WHILE @@FETCH_STATUS = 0
	begin

	declare @orgApplicantid int;
	declare @orgAppnameid int;

	insert into applicant(LkEntityType, LKEntityType2, Individual, Finlegal) values(476, 26242, 0, 0)
	set @orgApplicantid = @@identity;
	
	insert into appname (applicantname)	values (@OrganizationName)
	set @orgAppnameid = @@identity	

	select @orgAppnameid

	insert into applicantappname (applicantid, appnameid, defname) values (@orgApplicantid, @orgAppnameid, 1)

	FETCH NEXT FROM NewCursor INTO @OrganizationName
	END

Close NewCursor
deallocate NewCursor
go