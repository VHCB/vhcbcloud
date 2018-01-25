
create procedure dbo.add_new_applicant
(
	@IsIndividual bit,
	@EntityType int,
	@FiscalYearEnd nvarchar(10),
	@Website nvarchar(150),
	@StateVendorId nvarchar(24),
	@PhoneType	int,
	@Phone	nchar(20),
	@ApplicantName varchar(120),

	@Prefix int =null,
	@Fname varchar(20) =null,
	@Lname	varchar(35) =null,
	@Suffix int =null,
	@Position int =null,
	@Title nvarchar(50) =null,
	@Email nvarchar(150) =null,

	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@AddressType int,
	@IsActive bit,
	@DefAddress bit
) as
begin transaction

	begin try

	declare @contactid int;
	declare @applicantid int;
	declare @appnameid int;
	declare @AddressId int;

	if (@isindividual = 1)
	begin

		insert into contact (LkPrefix, Firstname, Lastname, LkSuffix, LkPosition, Title)
		values(@Prefix, @Fname, @Lname, @Suffix, @Position, @Title)

		set @contactid = @@identity;

		insert into applicant(LkEntityType, Individual, FYend, website, email, LkPhoneType, Phone, Stvendid, UserID)
		values(@EntityType, @IsIndividual, @FiscalYearEnd, @Website, @Email, @PhoneType, @Phone, @StateVendorId, 123)

		set @applicantid = @@identity;

		insert into applicantcontact(ApplicantID, ContactID, DfltCont)
		values(@applicantid, @contactid, 1)

		insert into appname (applicantname) values ( @lname +', '+ @fname)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)

	end
	else 
	begin
		insert into applicant(LkEntityType, Individual, FYend, website, email, LkPhoneType, Phone, Stvendid, UserID)
		values(@EntityType, @IsIndividual, @FiscalYearEnd, @Website, @Email, @PhoneType, @Phone, @StateVendorId, 123)

		set @applicantid = @@identity;

		insert into appname (applicantname)
		values (@ApplicantName)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)
	end

	if(@StreetNo != '')
	begin
		insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, RowIsActive, UserID)
		values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @IsActive, 123)

		set @AddressId = @@identity	

		insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
		values(@AddressId, @applicantid, @DefAddress, @IsActive, getdate())
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