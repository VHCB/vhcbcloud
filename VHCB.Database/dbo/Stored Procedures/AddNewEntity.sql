
create procedure dbo.AddNewEntity
(
	@LkEntityType		int,
	@LKEntityType2		int,
	@FYend				nvarchar(5),
	@Website			nvarchar(75),
	@Email				nvarchar(75) = null,
	@HomePhone			nchar(10) = null,
	@WorkPhone			nchar(10) = null,
	@CellPhone			nchar(10) = null,
	@Stvendid			nvarchar(24) = null,
	@ApplicantName		varchar(120) = null,

	@Fname				varchar(20) = null,
	@Lname				varchar(35) = null,
	@Position			int	= null,
	@Title				nvarchar(50) = null,
 
	@FarmName			nvarchar(50) = null,
	@LkFVEnterpriseType int = null,
	@AcresInProduction	int = null,
	@AcresOwned			int = null,
	@AcresLeased		int = null,
	@AcresLeasedOut		int = null,
	@TotalAcres			int = null,
	@OutOFBiz			bit = null,
	@Notes				nvarchar(max) = null,
	@AgEd				nvarchar(max) = null,
	@YearsManagingFarm	int = null,
	@AppRole			int = null,
	@Operation			int = null,
	@isDuplicate		bit output,
	@DuplicateId		int output,
	@ApplicantId		int output
) as
begin transaction

	begin try

	declare @contactid int;
	declare @appnameid int;
	declare @AddressId int;

	set @isDuplicate = 0
	set @DuplicateId = 0;

	if (@Operation = 1)--Individual
	begin

	set @isDuplicate = 1

	if exists
	(
		select 1
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		join applicant a(nolock) on ac.ApplicantID = a.ApplicantID
		where c.Firstname = @Fname 
		and c.Lastname = @Lname
		and a.email != '' and a.email = @Email
	)
	begin
		set @DuplicateId = 3
	end
	else if exists
	(
		select 1
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		join applicant a(nolock) on ac.ApplicantID = a.ApplicantID
		where c.Firstname = @Fname 
		and c.Lastname = @Lname
	)
	begin
		set @DuplicateId = 2
	end
	else if exists
	(
		select 1
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		join applicant a(nolock) on ac.ApplicantID = a.ApplicantID
		where  @Email != '' and a.email = @email
	)
	begin
		set @DuplicateId = 1
	end
	else
		begin
			insert into contact (Firstname, Lastname, LkPosition, Title)
			values (@Fname, @Lname, @Position, @Title)

			set @contactid = @@identity;

			insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, AppRole)
			values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @Position)

			set @applicantid = @@identity;

			insert into applicantcontact(ApplicantID, ContactID, DfltCont)
			values(@applicantid, @contactid, 1)

			insert into appname (applicantname) values ( @lname +', '+ @fname)
			set @appnameid = @@identity	

			insert into applicantappname (applicantid, appnameid, defname)
			values (@applicantid, @appnameid, 1)

			set @isDuplicate = 0
		end
	end
	else if (@Operation = 2)--Organization
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, AppRole)
		values(@LkEntityType, @LKEntityType2, 0, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @AppRole)

		set @applicantid = @@identity;

		insert into appname (applicantname)
		values (@ApplicantName)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)

		set @isDuplicate = 0
	end
	else if (@Operation = 3)--Farm
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, AppRole)
		values(@LkEntityType, @LKEntityType2, 0, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @AppRole)

		set @applicantid = @@identity;

		insert into appname (applicantname)
		values (@ApplicantName)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)

		insert into Farm(ApplicantID, FarmName, LkFVEnterpriseType, AcresInProduction, AcresOwned, AcresLeased, AcresLeasedOut, TotalAcres, OutOFBiz, 
			Notes, AgEd, YearsManagingFarm, DateCreated)
		values(@applicantid, @FarmName, @LkFVEnterpriseType, @AcresInProduction, @AcresOwned, @AcresLeased, @AcresLeasedOut, @TotalAcres, @OutOFBiz, 
			@Notes, @AgEd, @YearsManagingFarm, getdate())

		set @isDuplicate = 0
	end

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
      RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;