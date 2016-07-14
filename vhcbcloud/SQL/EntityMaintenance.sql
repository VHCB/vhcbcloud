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
	@isDuplicate		bit output,
	@ApplicantId		int output
) as
begin transaction

	begin try

	declare @contactid int;
	declare @appnameid int;
	declare @AddressId int;

	set @isDuplicate = 0

	if (@LKEntityType2 = 26243)--Individual
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

	end
	else if (@LKEntityType2 = 26242)--Organization
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid)
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid)

		set @applicantid = @@identity;

		insert into appname (applicantname)
		values (@ApplicantName)
		set @appnameid = @@identity	

		insert into applicantappname (applicantid, appnameid, defname)
		values (@applicantid, @appnameid, 1)
	end
	else if (@LKEntityType2 = 26244)--Farm
	begin
		insert into applicant(LkEntityType, LKEntityType2, Individual, FYend, website, email, HomePhone, WorkPhone, CellPhone, Stvendid)
		values(@LkEntityType, @LKEntityType2, 1, @FYend, @Website, @Email, @HomePhone, @WorkPhone, @CellPhone, @Stvendid)

		set @applicantid = @@identity;

		insert into Farm(ApplicantID, FarmName, LkFVEnterpriseType, AcresInProduction, AcresOwned, AcresLeased, AcresLeasedOut, TotalAcres, OutOFBiz, 
			Notes, AgEd, YearsManagingFarm, DateCreated)
		values(@applicantid, @FarmName, @LkFVEnterpriseType, @AcresInProduction, @AcresOwned, @AcresLeased, @AcresLeasedOut, @TotalAcres, @OutOFBiz, 
			@Notes, @AgEd, @YearsManagingFarm, getdate())
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
--exec GetEntityData 1070
	declare @LKEntityType2 int

	select @LKEntityType2 = LKEntityType2
	from applicant a(nolock) 
	where  a.ApplicantId = @ApplicantId

	select a.LkEntityType, a.LKEntityType2, a.Individual, a.FYend, a.website, a.email, a.HomePhone, a.WorkPhone, a.CellPhone, a.Stvendid,
		c.Firstname, c.Lastname, c.LkPosition, c.Title,
		an.Applicantname,
		f.ApplicantID, f.FarmName, f.LkFVEnterpriseType, f.AcresInProduction, f.AcresOwned, f.AcresLeased, f.AcresLeasedOut, f.TotalAcres, f.OutOFBiz, 
			f.Notes, f.AgEd, f.YearsManagingFarm
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
	@LKEntityType2	int
)
as
begin
--exec GetEntitiesByRole 26242
	if(@LKEntityType2 != 26244)
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