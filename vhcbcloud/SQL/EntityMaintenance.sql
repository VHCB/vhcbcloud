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
	@ApplicantId		int output
) as
begin transaction

	begin try

	declare @contactid int;
	declare @appnameid int;
	declare @AddressId int;

	set @isDuplicate = 0

	if (@Operation = 1)--Individual
	begin

	set @isDuplicate = 1
	
		if not exists
		(
			select 1
			from contact c(nolock)
			join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
			join applicant a(nolock) on ac.ApplicantID = a.ApplicantID
			where c.Firstname = @Fname 
				and c.Lastname = @Lname
				and a.email = @Email
		)
		begin
			insert into contact (Firstname, Lastname, LkPosition, Title)
			values (@Fname, @Lname, @Position, @Title)

			set @contactid = @@identity;

			insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid)
			values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid)

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
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @AppRole)

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
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid, @AppRole)

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

go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEntity]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEntity
go

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

		update c set Firstname = @Fname, Lastname = @Lname, LkPosition =@Position, Title = @Title
		from contact c(nolock)
		join applicantcontact ac(nolock) on c.ContactID = ac.ContactID
		where ac.ApplicantId = @ApplicantId

		update applicant 
		set  LkEntityType = @LkEntityType, FYend = @FYend, website = @Website, Stvendid = @Stvendid, 
			HomePhone = @HomePhone, CellPhone = @CellPhone, WorkPhone = @WorkPhone, email = @Email
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

go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntityData]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEntityData
go

create procedure dbo.GetEntityData
(
	@ApplicantId		int
)
as
begin
--exec GetEntityData 1076
	declare @LKEntityType2 int

	select @LKEntityType2 = LKEntityType2
	from applicant a(nolock) 
	where  a.ApplicantId = @ApplicantId

	select a.LkEntityType, a.LKEntityType2, a.Individual, a.FYend, a.website, a.email, a.HomePhone, a.WorkPhone, a.CellPhone, a.Stvendid, a.AppRole,
		c.Firstname, c.Lastname, c.LkPosition, c.Title,
		an.Applicantname,
		f.ApplicantID, f.FarmId, f.FarmName, f.LkFVEnterpriseType, f.AcresInProduction, f.AcresOwned, f.AcresLeased, f.AcresLeasedOut, f.TotalAcres, 
		f.OutOFBiz, f.Notes, f.AgEd, f.YearsManagingFarm
	from applicant a(nolock) 
	left join applicantcontact ac(nolock) on ac.ApplicantID = a.ApplicantID
	left join contact c(nolock) on c.ContactId = ac.ContactID
	left join applicantappname aan(nolock) on aan.ApplicantID = a.ApplicantId
	left join appname an(nolock) on an.AppNameID = aan.AppNameID
	left join farm f(nolock) on f.ApplicantID = a.ApplicantId
	where  a.ApplicantId = @ApplicantId

end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntitiesByRole]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEntitiesByRole
go

create procedure dbo.GetEntitiesByRole
(
	@LKEntityType2	int,
	@Operation		int
)
as
begin
--exec GetEntitiesByRole 26242
	if(@Operation != 3) --3 is farm
	begin
		select a.ApplicantId, an.ApplicantName 
		from Appname an(nolock)
		join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.ApplicantID
		where LKEntityType2 = @LKEntityType2
		order by an.Applicantname asc 
	end
	else
	begin
		select a.ApplicantId, f.FarmName as ApplicantName
		from Farm f(nolock)
		join Applicant a(nolock) on a.ApplicantId = f.ApplicantID
	end
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddNewEntityAddress]') and type in (N'P', N'PC'))
drop procedure [dbo].AddNewEntityAddress
go

create procedure dbo.AddNewEntityAddress
(
	@ApplicantId int,

	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@AddressType int,
	@DefAddress bit,
	@latitude float,
	@longitude	float,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	declare @AddressId int;
	declare @ApplicantAddressID int;

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from Address a(nolock) 
		join ApplicantAddress aa(nolock) on a.AddressId = aa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and aa.ApplicantId = @ApplicantId
	)
	begin
		insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, latitude, longitude, RowIsActive, UserID)
		values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @latitude, @longitude, @IsActive, 123)

		set @AddressId = @@identity	

		insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
		values(@AddressId, @ApplicantId, @DefAddress, @IsActive, getdate())

		set @ApplicantAddressID = @@identity

		if(@DefAddress = 1)
		begin
		 update ApplicantAddress set Defaddress = 0 where ApplicantId = @ApplicantId and ApplicantAddressID != @ApplicantAddressID
		end

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  a.RowIsActive 
		from Address a(nolock) 
		join ApplicantAddress aa(nolock) on a.AddressId = aa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and aa.ApplicantId = @ApplicantId
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

go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntityAddressDetailsList]') and type in (N'P', N'PC'))
drop procedure dbo.GetEntityAddressDetailsList
go

create procedure dbo.GetEntityAddressDetailsList
(
	@ApplicantId	int,
	@IsActiveOnly	bit
)
as 
--exec GetEntityAddressDetailsList 1034, 1
Begin

	select a.AddressId, a.LkAddressType, 
	case (rtrim(ltrim(lv.description))) when 'Physical Location'then 'Physical'
	else  (rtrim(ltrim(lv.description))) end as AddressType, 
	a.Street#, a.Address1, a.Address2, a.latitude, a.longitude, a.Town, a.State, a.Zip, a.County, ad.Defaddress, a.RowIsActive
	from ApplicantAddress ad(nolock) 
	join Address a(nolock) on a.Addressid = ad.AddressId
	left join LookupValues lv(nolock) on lv.typeid = a.LkAddressType
	where ad.ApplicantId = @ApplicantId
	and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
	order by ad.DefAddress desc, ad.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntityAddressDetailsById]') and type in (N'P', N'PC'))
drop procedure dbo.GetEntityAddressDetailsById
go

create procedure [dbo].GetEntityAddressDetailsById
(
	@ApplicantId	int,
	@AddressId		int
)
as 
--exec GetEntityAddressDetailsById 20, 20
Begin

	select a.LkAddressType,  a.AddressId, isnull(a.Street#, '') as Street#, isnull(a.Address1, '') as Address1, isnull(a.Address2, '') as Address2, 
	isnull(a.latitude, '') as latitude, isnull(a.longitude, '') as longitude, isnull(a.Town, '') as Town, isnull(a.State, '') as State, 
	isnull(a.Zip, null) as Zip, 
	isnull(a.County, '') as County, isnull(Village, '') as Village,
	a.RowIsActive, pa.DefAddress
	from ApplicantAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	where a.AddressId= @AddressId and pa.ApplicantId = @ApplicantId
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEntityAddress]') and type in (N'P', N'PC'))
drop procedure dbo.UpdateEntityAddress
go

create procedure dbo.UpdateEntityAddress
(
	@ApplicantId int,
	@AddressId int,
	@LkAddressType	int,
	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@IsActive bit,
	@DefAddress bit,
	@latitude float,
	@longitude	float
)
as
begin transaction

	begin try

	update Address
		set 
		LkAddressType = @LkAddressType,
		Street# = @StreetNo,
		Address1 = @Address1,
		Address2 = @Address2,
		Town = @Town,
		State = @State,
		Zip = @Zip,
		County = @County,
		latitude = @latitude,
		longitude = @longitude,
		RowIsActive = @IsActive,
		DateModified = getdate()
	from Address
	where AddressId= @AddressId

	if(@Defaddress = 1 and @IsActive = 1)
	begin
	 update ApplicantAddress set DefAddress = 0 where ApplicantId = @ApplicantId
	end
	
	update ApplicantAddress
	set DefAddress = @Defaddress
	from ApplicantAddress
	where ApplicantId = @ApplicantId and AddressId= @AddressId

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

/* Attribute */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFarmAttributesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFarmAttributesList
go

create procedure GetFarmAttributesList
(
	@FarmId			int,
	@IsActiveOnly	bit
)  
as
--exec GetFarmAttribList 1, 1
begin
	select  fa.FarmAttributeID, fa.LKFarmAttributeID, lv.Description as Attribute, fa.RowIsActive
	from FarmAttributes fa(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fa.LKFarmAttributeID
	where fa.FarmId = @FarmId
	and (@IsActiveOnly = 0 or fa.RowIsActive = @IsActiveOnly)
		order by fa.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddFarmAttribute]') and type in (N'P', N'PC'))
drop procedure [dbo].AddFarmAttribute
go

create procedure dbo.AddFarmAttribute
(
	@FarmId				int,
	@LKFarmAttributeID	int,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from FarmAttributes(nolock)
		where FarmId = @FarmId 
			and LKFarmAttributeID = @LKFarmAttributeID
    )
	begin
		insert into FarmAttributes(FarmId, LKFarmAttributeID, DateModified)
		values(@FarmId, @LKFarmAttributeID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from FarmAttributes(nolock)
		where FarmId = @FarmId 
			and LKFarmAttributeID = @LKFarmAttributeID
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateFarmAttribute]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateFarmAttribute
go

create procedure dbo.UpdateFarmAttribute
(
	@FarmAttributeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update FarmAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from FarmAttributes 
	where FarmAttributeID = @FarmAttributeID

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

/* FarmProducts */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetFarmProductsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetFarmProductsList
go

create procedure GetFarmProductsList
(
	@FarmId			int,
	@IsActiveOnly	bit
)  
as
--exec GetFarmProductsList 1, 1
begin
	select fp.FarmProductsID, fp.LkProductCrop, lv.Description as Product, fp.StartDate, fp.RowIsActive 
	from FarmProducts fp(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fp.LkProductCrop
	where fp.FarmId = @FarmId
	and (@IsActiveOnly = 0 or fp.RowIsActive = @IsActiveOnly)
		order by fp.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddFarmProducts]') and type in (N'P', N'PC'))
drop procedure [dbo].AddFarmProducts
go

create procedure dbo.AddFarmProducts
(
	@FarmId				int,
	@LkProductCrop		int,
	@StartDate			datetime,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from FarmProducts(nolock)
		where FarmId = @FarmId 
			and LkProductCrop = @LkProductCrop
    )
	begin
		insert into FarmProducts(FarmId, LkProductCrop, StartDate, DateModified)
		values(@FarmId, @LkProductCrop, @StartDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from FarmProducts(nolock)
		where FarmId = @FarmId 
			and LkProductCrop = @LkProductCrop
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateFarmProducts]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateFarmProducts
go

create procedure dbo.UpdateFarmProducts
(
	@FarmProductsID		int,
	@StartDate			datetime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update FarmProducts set  StartDate = @StartDate, RowIsActive = @RowIsActive, DateModified = getdate()
	from FarmProducts 
	where FarmProductsID = @FarmProductsID

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

/* ApplicantApplicant */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetApplicantApplicantList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetApplicantApplicantList
go

create procedure GetApplicantApplicantList
(
	@ApplicantId	int,
	@IsActiveOnly	bit
)  
as
--exec GetApplicantApplicantList 1, 1
begin
	select aa.ApplicantApplicantId, aa.AttachedApplicantId, an.Applicantname as AttachedApplicantName, aa.RowIsActive 
	from ApplicantApplicant aa(nolock)
	join ApplicantAppName aaname(nolock) on aaname.ApplicantID = aa.AttachedApplicantId
	join AppName an(nolock) on an.AppNameID = aaname.AppNameID
	where aa.ApplicantId = @ApplicantId
	and (@IsActiveOnly = 0 or aa.RowIsActive = @IsActiveOnly)
		order by aa.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddApplicantApplicant]') and type in (N'P', N'PC'))
drop procedure [dbo].AddApplicantApplicant
go

create procedure dbo.AddApplicantApplicant
(
	@ApplicantId				int,
	@AttachedApplicantId		int,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from ApplicantApplicant(nolock)
		where ApplicantId = @ApplicantId 
			and AttachedApplicantId = @AttachedApplicantId
    )
	begin
		insert into ApplicantApplicant(ApplicantId, AttachedApplicantId)
		values(@ApplicantId, @AttachedApplicantId)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ApplicantApplicant(nolock)
		where ApplicantId = @ApplicantId 
			and AttachedApplicantId = @AttachedApplicantId
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateApplicantApplicant]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateApplicantApplicant
go

create procedure dbo.UpdateApplicantApplicant
(
	@ApplicantApplicantId	int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ApplicantApplicant set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ApplicantApplicant 
	where ApplicantApplicantId = @ApplicantApplicantId

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