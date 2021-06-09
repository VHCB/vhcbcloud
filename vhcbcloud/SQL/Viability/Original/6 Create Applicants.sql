use vhcbsandbox
go

	DECLARE @Projectid int, @ProjectName nvarchar(250), @Convert nvarchar(10), @OrganizationName nvarchar(250), @LKEntityType int, @LKEntityType2 int,
	@FirstName nvarchar(250), @Lastname nvarchar(250), @PhoneHome  nvarchar(250), @PhoneWork  nvarchar(250), 
	@PhoneCell  nvarchar(250), 
	@Email  nvarchar(250),
	@StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State as varchar(100), @Zip as varchar(100), @County as varchar(100)

	declare NewCursor Cursor for
	select Projectid, ProjectName, [Convert], OrganizationName, LKEntityType, LKEntityType2, FirstName, Lastname, PhoneHome, PhoneWork, PhoneCell, Email, StreetNo, Address1, Address2, Town, State, Zip, County
	from FinalViabConversionApplicant_v where [Convert] = 'Y' --and ProjectId = 6893
	order by ProjectName, [Convert] desc

	open NewCursor
	fetch next from NewCursor into @Projectid, @ProjectName, @Convert, @OrganizationName, @LKEntityType, @LKEntityType2, @FirstName, @Lastname, @PhoneHome, @PhoneWork, @PhoneCell, @Email,
		@StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	WHILE @@FETCH_STATUS = 0
	begin

	declare @contactid int;
	declare @appnameid int;
	declare @ApplicantId int;
	declare @orgApplicantid int;
	declare @orgAppnameid int;
	declare @addressId int;
	declare @orgAddressId int;
	--**************************Contact******************Farmer
	insert into contact (Firstname, Lastname, LKPosition) values (@FirstName, @Lastname, 26708)

	set @contactid = @@identity;

	insert into applicant(LkEntityType, LKEntityType2, Individual, email, HomePhone, WorkPhone, CellPhone, AppRole) values(@LKEntityType, 26243, 1, @Email, @PhoneHome, @PhoneWork, @PhoneCell, null)

	set @applicantid = @@identity;

	insert into applicantcontact(ApplicantID, ContactID, DfltCont) values(@applicantid, @contactid, 1)

	insert into appname (applicantname) values ( @Lastname +', '+ @FirstName)
	set @appnameid = @@identity	

	insert into applicantappname (applicantid, appnameid, defname) values (@applicantid, @appnameid, 1)

	insert into dbo.Address(LKaddresstype, [Street#], [Address1], [Address2], [Town],[State], [Zip], [County]) values(26240, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County)
	set @addressId = @@identity

	insert into ApplicantAddress(AddressId, ApplicantId, DefAddress)
	values(@addressId, @applicantid, 1)

	--**************************Organization******************Farm *****Primary Applicant
	--insert into applicant(LkEntityType, LKEntityType2, Individual, email, HomePhone, WorkPhone, CellPhone, AppRole) values(@LkEntityType, 26242, 0, @Email,  @PhoneHome, @PhoneWork, @PhoneCell, 358)
	insert into applicant(LkEntityType, LKEntityType2, Individual, email, HomePhone, WorkPhone, CellPhone, AppRole) values(477, 26242, 0, @Email,  @PhoneHome, @PhoneWork, @PhoneCell, 358)
	set @orgApplicantid = @@identity;

	insert into appname (applicantname)	values (@OrganizationName)
	set @orgAppnameid = @@identity	

	insert into applicantappname (applicantid, appnameid, defname) values (@orgApplicantid, @orgAppnameid, 1)

	--insert into dbo.Address(LKaddresstype, [Street#], [Address1], [Address2], [Town],[State], [Zip], [County]) values(26240, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County)
	--set @orgAddressId = @@identity

	insert into ApplicantAddress(AddressId, ApplicantId, DefAddress)
	values(@addressId, @orgApplicantid, 1)

	--**************************ProjectApplicant
	insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal) values (@ProjectId, @orgApplicantid, 358, 1, 1)
	insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal) values (@ProjectId, @applicantid, 25922, 0, 0) --25922: Secondary Applicant

	--**************************ApplicantApplicant
	insert into ApplicantApplicant(ApplicantId, AttachedApplicantId) values(@applicantid, @orgApplicantid)
	insert into ApplicantApplicant(ApplicantId, AttachedApplicantId) values(@orgApplicantid, @applicantid)

	FETCH NEXT FROM NewCursor INTO @Projectid, @ProjectName, @Convert, @OrganizationName, @LKEntityType, @LKEntityType2, @FirstName, @Lastname, @PhoneHome, @PhoneWork, @PhoneCell, @Email,
		@StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	END

Close NewCursor
deallocate NewCursor
go