use VHCBSandbox 
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddNewEntity]') and type in (N'P', N'PC'))
drop procedure [dbo].AddNewEntity
go

create procedure dbo.AddNewEntity
(
	@LkEntityType		int,
	@LKEntityType2		int,
	@FYend				nvarchar(5),
	@Website			nvarchar(75),
	@Email				nvarchar(75),
	@HomePhone			nchar(10) = null,
	@WorkPhone			nchar(10) = null,
	@CellPhone			nchar(10) = null,
	@Stvendid			nvarchar(24) = null,
	@ApplicantName		varchar(120) = null,

	@Fname				varchar(20) = null,
	@Lname				varchar(35) = null,
	@Position			int	= null,
	@Title				nvarchar(50) = null,
	@UserID				int = null,
 
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
	@isDuplicate		bit output,
	@ApplicantId		int output
) as
begin transaction

	begin try

	declare @contactid int;
	declare @appnameid int;
	declare @AddressId int;

	set @isDuplicate = 0

	if (@LKEntityType2 = 1)--Individual
	begin

		insert into contact (Firstname, Lastname, LkPosition, Title)
		values (@Fname, @Lname, @Position, @Title)

		set @contactid = @@identity;

		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, UserID)
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @UserID)

		set @applicantid = @@identity;

		insert into applicantcontact(ApplicantID, ContactID, DfltCont)
		values(@applicantid, @contactid, 1)

		insert into appname (applicantname) values ( @lname +', '+ @fname)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)

	end
	else if (@LKEntityType2 = 2)--Organization
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, UserID)
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @UserID)

		set @applicantid = @@identity;

		insert into appname (applicantname)
		values (@ApplicantName)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)
	end
	else if (@LKEntityType2 = 3)--Farm
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid, UserID)
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @UserID)

		set @applicantid = @@identity;

		insert into Farm(ApplicantID, FarmName, LkFVEnterpriseType, AcresInProduction, AcresOwned, AcresLeased, AcresLeasedOut, TotalAcres, OutOFBiz, 
			Notes, AgEd, YearsManagingFarm)
		values(@applicantid, @FarmName, @LkFVEnterpriseType, @AcresInProduction, @AcresOwned, @AcresLeased, @AcresLeasedOut, @TotalAcres, @OutOFBiz, 
			@Notes, @AgEd, @YearsManagingFarm)
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

