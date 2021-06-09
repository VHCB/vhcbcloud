use vhcbsandbox
go

	DECLARE @Projectid int, @ProjectName nvarchar(250), @Convert nvarchar(10), @OrganizationName nvarchar(250), @LKEntityType int, @LKEntityType2 int,
	@FirstName nvarchar(250), @Lastname nvarchar(250), @PhoneHome  nvarchar(250), @PhoneWork  nvarchar(250), 
	@PhoneCell  nvarchar(250), 
	@Email  nvarchar(250),
	@StreetNo as varchar(50), @Address1 as varchar(100), @Address2 as varchar(100), @Town as varchar(100), @State as varchar(100), @Zip as varchar(100), @County as varchar(100)

	declare NewCursor Cursor for
	select Projectid, ProjectName, [Convert], OrganizationName, LKEntityType, LKEntityType2, FirstName, Lastname, PhoneHome, PhoneWork, PhoneCell, Email, StreetNo, Address1, Address2, Town, State, Zip, County
	from FinalViabConversionApplicant_v where [Convert] = 'N' --and ProjectId = 6892
	order by ProjectName, [Convert] desc

	open NewCursor
	fetch next from NewCursor into @Projectid, @ProjectName, @Convert, @OrganizationName, @LKEntityType, @LKEntityType2, @FirstName, @Lastname, @PhoneHome, @PhoneWork, @PhoneCell, @Email,
		@StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	WHILE @@FETCH_STATUS = 0
	begin

	declare @EProjectid int

	select @EProjectid = Projectid from FinalViabConversionApplicant_v where [Convert] = 'Y' and ProjectName = @ProjectName
	
	insert into ProjectApplicant(ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal) 
	select @Projectid, ApplicantId, LKApplicantRole, IsApplicant, FinLegal from ProjectApplicant where ProjectId = @EProjectid

	FETCH NEXT FROM NewCursor INTO @Projectid, @ProjectName, @Convert, @OrganizationName, @LKEntityType, @LKEntityType2, @FirstName, @Lastname, @PhoneHome, @PhoneWork, @PhoneCell, @Email,
		@StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County
	END

Close NewCursor
deallocate NewCursor
go