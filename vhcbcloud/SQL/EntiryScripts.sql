use vhcbsandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[get_lookup_values]') and type in (N'P', N'PC'))
drop procedure [dbo].get_lookup_values
go

create procedure dbo.get_lookup_values
(
	@lookuptype int
) as	
begin
-- dbo.get_lookup_values 29
	set nocount on   
	  
	select typeid, description
	from lookupvalues 
	where rowisactive = 1 and lookuptype = @lookuptype
	order by typeid

	if (@@error <> 0)    
    begin  
        raiserror ( 'get_lookup_values failed for lookuptype %d' , 0 ,1 , @lookuptype)  
        return 1  
    end  
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[add_new_applicant]') and type in (N'P', N'PC'))
drop procedure [dbo].add_new_applicant
go

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

	insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, RowIsActive, UserID)
	values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @IsActive, 123)

	set @AddressId = @@identity	

	insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
	values(@AddressId, @applicantid, @DefAddress, @IsActive, getdate())

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateApplicantDetails]') and type in (N'P', N'PC'))
drop procedure [dbo].[UpdateApplicantDetails]
go

create procedure [dbo].UpdateApplicantDetails
(
	@ApplicantId int,
	@IsIndividual bit,
	@EntityType int,
	@FiscalYearEnd nvarchar(10),
	@Website nvarchar(150),
	@StateVendorId nvarchar(24),
	@PhoneType	int,
	@Phone	nchar(20),
	@ApplicantName varchar(120),

	@Prefix int = null,
	@Fname varchar(20) = null,
	@Lname	varchar(35) = null,
	@Suffix int = null,
	@Position int = null,
	@Title nvarchar(50) = null,
	@Email nvarchar(150) = null
)
as 
--exec UpdateApplicantDetails 417
Begin

	if (@isindividual = 1)
	begin
		update c set LkPrefix = @Prefix, Firstname = @Fname, Lastname = @Lname, LkSuffix = @Suffix, LkPosition =@Position, Title = @Title
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		where ac.ApplicantId = @ApplicantId

		set @ApplicantName = @lname +', '+ @fname
	end

	update applicant 
	set LkEntityType = @EntityType, FYend = @FiscalYearEnd, website = @Website, Stvendid = @StateVendorId, 
		LkPhoneType = @PhoneType, Phone = @Phone, email = @Email
	from applicant where  ApplicantId = @ApplicantId

	update an set an.Applicantname = @ApplicantName
	from applicant a(nolock) 
	join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
	join appname an(nolock) on aan.AppNameID = an.AppNameID
	where a.ApplicantId = @ApplicantId

end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantNameForAutoComplete]') and type in (N'P', N'PC'))
drop procedure [dbo].[GetApplicantNameForAutoComplete]
go

create procedure [dbo].[GetApplicantNameForAutoComplete]
(
	@applicantNamePrefix varchar(75)	
)
as 
--exec GetApplicantNameForAutoComplete 'ram'
Begin
	select AppNameId, applicantname from appname  where applicantname like @applicantNamePrefix + '%'  order by applicantname 	
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantDetails]') and type in (N'P', N'PC'))
drop procedure [dbo].[GetApplicantDetails]
go

create procedure [dbo].GetApplicantDetails
(
	@appnameid int	
)
as 
--exec GetApplicantDetails 417
Begin

	select a.ApplicantId, a.Individual, a.LkEntityType, a.FYend, a.website, a.Stvendid, a.LkPhoneType, a.Phone, a.email, 
			an.applicantname,
			c.LkPrefix, c.Firstname, c.Lastname, c.LkSuffix, c.LkPosition, c.Title, 
			ac.ApplicantID, ac.ContactID, ac.DfltCont, 
			aan.appnameid, aan.defname
		from applicantappname aan(nolock) 
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID 
		where an.appnameid = @appnameid

end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantAddressDetails]') and type in (N'P', N'PC'))
drop procedure [dbo].[GetApplicantAddressDetails]
go

create procedure [dbo].[GetApplicantAddressDetails]
(
	@appnameid int	
)
as 
--exec GetApplicantAddressDetails 1033
Begin

	select a.AddressId, a.LkAddressType, a.Street#, a.Address1, a.Address2, a.latitude, a.longitude, a.Town, a.State, a.Zip, a.County, ad.Defaddress
	from ApplicantAddress ad(nolock) 
	join applicantappname aan(nolock) on ad.ApplicantId = aan.ApplicantId
	join Address a(nolock) on a.Addressid = ad.AddressId
	where aan.appnameid = @appnameid
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantAddressDetailsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetApplicantAddressDetailsById
go

create procedure [dbo].GetApplicantAddressDetailsById
(
	@AddressId int
)
as 
--exec GetApplicantAddressDetailsById 47
Begin

	select a.AddressId, isnull(a.LkAddressType, '') as LkAddressType, isnull(a.Street#, '') as Street#, isnull(a.Address1, '') as Address1, isnull(a.Address2, '') as Address2, 
	isnull(a.latitude, '') as latitude, isnull(a.longitude, '') as longitude, isnull(a.Town, '') as Town, isnull(a.State, '') as State, isnull(a.Zip, null) as Zip, isnull(a.County, '') as County, 
	a.RowIsActive, ad.Defaddress
	from ApplicantAddress ad(nolock) 
	--join applicantappname aan(nolock) on ad.ApplicantId = aan.ApplicantId
	join Address a(nolock) on a.Addressid = ad.AddressId
	where a.AddressId= @AddressId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateApplicantAddress]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateApplicantAddress
go

create procedure [dbo].UpdateApplicantAddress
(
	@AddressId int,
	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	--@TownCountyID int,
	@AddressType int,
	@IsActive bit,
	@DefAddress bit	
)
as 
Begin

	update Address
		set LkAddressType = @AddressType,
		Street# = @StreetNo,
		Address1 = @Address1,
		Address2 = @Address2,
		--TownCountyID = @TownCountyID,
		Town = @Town,
		State = @State,
		Zip = @Zip,
		County = @County,
		RowIsActive = @IsActive
	from Address
	where AddressId= @AddressId

	update ApplicantAddress
	set Defaddress = @Defaddress
	from ApplicantAddress
	where AddressId= @AddressId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddApplicantAddress]') and type in (N'P', N'PC'))
drop procedure [dbo].AddApplicantAddress
go

create procedure [dbo].AddApplicantAddress
(
	@ApplicantId int,

	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	--@TownCountyID int,
	@AddressType int,
	@IsActive bit,
	@DefAddress bit	
)
as 
Begin
	declare @AddressId int;

	insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, RowIsActive, UserID)
	values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @IsActive, 123)

	set @AddressId = @@identity	

	insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
	values(@AddressId, @ApplicantId, @DefAddress, @IsActive, getdate())
end
go

--select distinct typeid, description
--from lookupvalues lv(nolock)
--join TownCounty tc(nolock) on tc.LKTown = lv.typeid
--where rowisactive = 1 and lookuptype = 89
--order by typeid


--create procedure PM_Get_Projects
--as
--begin
--	select AppNameID, Applicantname from AppName(nolock) where RowIsActive = 1 
--	order  by Applicantname
--end
--go

--alter procedure PM_Get_Primary_Applicant_Names
--as
--begin
--	select AppNameID, Applicantname from AppName(nolock) where RowIsActive = 1 
--	order  by Applicantname
--end
--go

--alter procedure PM_Get_Program_Names
--as
--begin
--	select TypeID, Description
--	from LookupValues 
--	where RowIsActive = 1 and LookupType = 34
--	order by typeid
--end
--go


--create procedure PM_Get_Project_Type
--as
--begin
--	select TypeID, Description
--	from LookupValues 
--	where RowIsActive = 1 and LookupType = 119
--	order by typeid
--end
--go

--create procedure PM_Get_App_Status
--as
--begin
--	select TypeID, Description
--	from LookupValues 
--	where RowIsActive = 1 and LookupType = 83
--	order by typeid
--end
--go

--select * from ProjectRelated

