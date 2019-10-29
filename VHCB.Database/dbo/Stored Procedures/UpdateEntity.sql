
create procedure dbo.UpdateEntity
(
	@ApplicantId		int,
	@LkEntityType		int,
	@LKEntityType2		int, --Not Updatable from UI
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
	@Operation			int = null
) as
begin transaction

	begin try

	declare @contactid int;
	declare @appnameid int;
	declare @AddressId int;


	if (@Operation = 1)--Individual
	begin

		update c set Firstname = @Fname, Lastname = @Lname, LkPosition = @Position, Title = @Title
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		where ac.ApplicantId = @ApplicantId

		update applicant 
		set  LkEntityType = @LkEntityType, FYend = @FYend, website = @Website, Stvendid = @Stvendid, 
			HomePhone = @HomePhone, CellPhone = @CellPhone, WorkPhone = @WorkPhone, email = @Email,
			AppRole = @Position
		from applicant where  ApplicantId = @ApplicantId

		update an set an.Applicantname =  @lname +', '+ @fname
		from applicant a(nolock) 
		join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
		join appname an(nolock) on aan.AppNameID = an.AppNameID
		where a.ApplicantId = @ApplicantId

	end
	else if (@Operation = 2)--Organization
	begin
		update applicant 
		set LkEntityType = @LkEntityType, FYend = @FYend, website = @Website, Stvendid = @Stvendid, 
			HomePhone = @HomePhone, CellPhone = @CellPhone, WorkPhone = @WorkPhone, email = @Email,
			AppRole = @AppRole
		from applicant where  ApplicantId = @ApplicantId

		update an set an.Applicantname = @ApplicantName
		from applicant a(nolock) 
		join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
		join appname an(nolock) on aan.AppNameID = an.AppNameID
		where a.ApplicantId = @ApplicantId
	end
	else if (@Operation = 3)--Farm
	begin
		update applicant 
		set LkEntityType = @LkEntityType, FYend = @FYend, website = @Website, Stvendid = @Stvendid, 
			HomePhone = @HomePhone, CellPhone = @CellPhone, WorkPhone = @WorkPhone, email = @Email,
			AppRole = @AppRole
		from applicant where  ApplicantId = @ApplicantId

		update an set an.Applicantname = @ApplicantName
		from applicant a(nolock) 
		join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
		join appname an(nolock) on aan.AppNameID = an.AppNameID
		where a.ApplicantId = @ApplicantId

		update farm
		set FarmName = @FarmName, LkFVEnterpriseType = @LkFVEnterpriseType, AcresInProduction = @AcresInProduction, 
			AcresOwned = @AcresOwned, AcresLeased = @AcresLeased, AcresLeasedOut = @AcresLeasedOut, TotalAcres = @TotalAcres, 
			OutOFBiz = @OutOFBiz, Notes = @Notes, AgEd = @AgEd, YearsManagingFarm = @YearsManagingFarm
		where ApplicantID = @ApplicantID
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