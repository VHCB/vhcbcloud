use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAMasterList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAMasterList
go

create procedure dbo.GetHOPWAMasterList
(
	@ProjectId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAMasterList 1
begin transaction

	begin try

	select HOPWAID, UUID, HHincludes, PrimaryASO, lv.description as PrimaryASOST,  WithHIV, InHousehold, Minors, Gender, Age, Ethnic, 
		Race, GMI, AMI, Beds, Notes, hm.RowisActive, hm.DateModified, substring(hm.Notes, 0, 25) Notes, hm.Notes as FullNotes
	from HOPWAMaster hm(nolock) 
	left join lookupvalues lv(nolock) on hm.PrimaryASO = lv.TypeID
	where ProjectId = @ProjectId and (@IsActiveOnly = 0 or hm.RowIsActive = @IsActiveOnly)
		order by hm.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAMasterDetailsByHOPWAID]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAMasterDetailsByHOPWAID
go

create procedure dbo.GetHOPWAMasterDetailsByHOPWAID
(
	@HOPWAID	int
) as
--GetHOPWAMasterDetailsByHOPWAID 1
begin transaction

	begin try

	select UUID, HHincludes,PrimaryASO, SpecNeeds, WithHIV, InHousehold, Minors, Gender, Age, Ethnic, Race, GMI, AMI, Beds, Notes, RowisActive, LivingSituationId
	from HOPWAMaster hm(nolock) 
	where hm.HOPWAID = @HOPWAID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAMaster
go

create procedure dbo.AddHOPWAMaster
(
	@UUID			nvarchar(6), 
	@HHincludes		nchar(6), 
	@SpecNeeds		int, 
	@WithHIV		int, 
	@InHousehold	int, 
	@Minors			int, 
	@Gender			int, 
	@Age			int, 
	@Ethnic			int, 
	@Race			int, 
	@GMI			money, 
	@AMI			money, 
	@Beds			int, 
	@Notes			nvarchar(max),
	@ProjectId		int,
	@LivingSituationId	int,
	@PrimaryASO		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1 
		from HOPWAMaster(nolock)
		where UUID = @UUID 
	)
	begin

		insert into HOPWAMaster(UUID, HHincludes, SpecNeeds, WithHIV, InHousehold, Minors, Gender, Age, 
			Ethnic, Race, GMI, AMI, Beds, Notes, ProjectID, LivingSituationId, PrimaryASO)
		values(@UUID, @HHincludes, @SpecNeeds, @WithHIV, @InHousehold, @Minors, @Gender, @Age, 
			@Ethnic, @Race, @GMI, @AMI, @Beds, @Notes, @ProjectId, @LivingSituationId, @PrimaryASO)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from HOPWAMaster(nolock)
		where  UUID = @UUID 
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAMaster
go

create procedure dbo.UpdateHOPWAMaster
(
	@HOPWAID		int, 
	@HHincludes		nchar(6), 
	@SpecNeeds		int,  
	@WithHIV		int, 
	@InHousehold	int, 
	@Minors			int, 
	@Gender			int, 
	@Age			int, 
	@Ethnic			int, 
	@Race			int, 
	@GMI			money, 
	@AMI			money, 
	@Beds			int,  
	@Notes			nvarchar(max),
	@LivingSituationId	int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update HOPWAMaster set HHincludes = @HHincludes, SpecNeeds = @SpecNeeds, WithHIV = @WithHIV, InHousehold = @InHousehold, 
		Minors = @Minors, Gender = @Gender, Age = @Age, Ethnic = @Ethnic, Race = @Race, GMI = @GMI, AMI = @AMI, Beds = @Beds, Notes = @Notes, 
		LivingSituationId = @LivingSituationId, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from HOPWAMaster
	where HOPWAID = @HOPWAID
	
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

/* HOPWA race*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWARaceList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWARaceList
go

create procedure dbo.GetHOPWARaceList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWARaceList 1, 1
begin transaction

	begin try

	select HOPWARaceID, Race, lv.Description as RaceName, HouseholdNum, hr.RowIsActive, hr.DateModified
	from HOPWARace hr(nolock) 
	join lookupvalues lv(nolock) on hr.Race = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or hr.RowIsActive = @IsActiveOnly)
		order by hr.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWARace]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWARace
go

create procedure dbo.AddHOPWARace
(
	@HOPWAID		int,
	@Race			int,
	@HouseholdNum	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from HOPWARace(nolock)
		where HOPWAID = @HOPWAID 
			and Race = @Race
    )
	begin
		insert into HOPWARace(HOPWAID, Race, HouseholdNum)
		values(@HOPWAID, @Race, @HouseholdNum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWARace(nolock)
		where HOPWAID = @HOPWAID 
			and Race = @Race
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWARace]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWARace
go

create procedure dbo.UpdateHOPWARace
(
	@HOPWARaceID	int,
	@Race			int,
	@HouseholdNum	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWARace set  Race= @Race, HouseholdNum = @HouseholdNum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWARace 
	where HOPWARaceID = @HOPWARaceID

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

/* HOPWA Ethnicity*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAEthnicityList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAEthnicityList
go

create procedure dbo.GetHOPWAEthnicityList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAEthnicityList 1, 1
begin transaction

	begin try

	select HOPWAEthnicID, Ethnic, lv.Description as EthnicName, EthnicNum, he.RowIsActive, he.DateModified
	from HOPWAEthnic he(nolock) 
	join lookupvalues lv(nolock) on he.Ethnic = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or he.RowIsActive = @IsActiveOnly)
		order by he.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAEthnicity]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAEthnicity
go

create procedure dbo.AddHOPWAEthnicity
(
	@HOPWAID		int,
	@Ethnic			int,
	@EthnicNum		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from HOPWAEthnic(nolock)
		where HOPWAID = @HOPWAID 
			and Ethnic = @Ethnic
    )
	begin
		insert into HOPWAEthnic(HOPWAID, Ethnic, EthnicNum)
		values(@HOPWAID, @Ethnic, @EthnicNum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAEthnic(nolock)
		where HOPWAID = @HOPWAID 
			and Ethnic = @Ethnic
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAEthnicity]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAEthnicity
go

create procedure dbo.UpdateHOPWAEthnicity
(
	@HOPWAEthnicID	int,
	@Ethnic			int,
	@EthnicNum	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAEthnic set  Ethnic = @Ethnic, EthnicNum = @EthnicNum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAEthnic 
	where HOPWAEthnicID = @HOPWAEthnicID

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

/* HOPWA Age*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAAgeList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAAgeList
go

create procedure dbo.GetHOPWAAgeList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAAgeList 1, 1
begin transaction

	begin try

	select HOPWAAgeId, GenderAgeID, lv.description as 'AgeGenderName', GANum, ha.RowisActive, ha.DateModified
	from HOPWAAge ha(nolock) 
	join lookupvalues lv(nolock) on ha.GenderAgeID = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or ha.RowIsActive = @IsActiveOnly)
		order by ha.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAAge]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAAge
go

create procedure dbo.AddHOPWAAge
(
	@HOPWAID		int,
	@GenderAgeID	int,
	@GANum			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from HOPWAAge(nolock)
		where HOPWAID = @HOPWAID 
			and GenderAgeID = @GenderAgeID
    )
	begin
		insert into HOPWAAge(HOPWAID, GenderAgeID, GANum)
		values(@HOPWAID, @GenderAgeID, @GANum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAAge(nolock)
		where HOPWAID = @HOPWAID 
			and GenderAgeID = @GenderAgeID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAAge]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAAge
go

create procedure dbo.UpdateHOPWAAge
(
	@HOPWAAgeId		int,
	@GenderAgeID	int,
	@GANum			int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAAge set  GenderAgeID = @GenderAgeID, GANum = @GANum, RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAAge 
	where HOPWAAgeId = @HOPWAAgeId

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

/* HOPWA Program*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAProgramList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAProgramList
go

create procedure dbo.GetHOPWAProgramList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAProgramList 3, 1
begin transaction

	begin try

	select HOPWAProgramID, Program, lv.description ProgramName, Fund,f.name as 'FundName', Yr1, Yr2, Yr3, 
		convert(varchar(10), StartDate, 101) StartDate, convert(varchar(10), EndDate, 101) EndDate, LivingSituationId, Notes, hp.RowIsactive, hp.DateModified
	from HOPWAProgram hp(nolock) 
	join lookupvalues lv(nolock) on hp.Program = lv.TypeID
	join Fund f(nolock) on f.fundid = hp.fund
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or hp.RowIsActive = @IsActiveOnly)
		order by hp.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAProgramById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAProgramById
go

create procedure dbo.GetHOPWAProgramById
(
	@HOPWAProgramID		int
) as
--GetHOPWAProgramById 1, 1
begin transaction

	begin try

	select Program, Fund, Yr1, Yr2, Yr3, convert(varchar(10), StartDate, 101) StartDate, convert(varchar(10), EndDate, 101) EndDate, LivingSituationId, Notes, RowIsactive, DateModified
	from HOPWAProgram hp(nolock) 
	where HOPWAProgramID = @HOPWAProgramID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAProgram]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAProgram
go

create procedure dbo.AddHOPWAProgram
(
	@HOPWAID	int, 
	@Program	int, 
	@Fund		int, 
	@Yr1		bit, 
	@Yr2		bit, 
	@Yr3		bit, 
	@StartDate	date, 
	@EndDate	date, 
	@Notes			nvarchar(max),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from HOPWAProgram(nolock)
		where HOPWAID = @HOPWAID 
			and Program = @Program
    )
	begin
		insert into HOPWAProgram(HOPWAID, Program, Fund, Yr1, Yr2, Yr3, StartDate, EndDate, Notes)
		values(@HOPWAID, @Program, @Fund, @Yr1, @Yr2, @Yr3, @StartDate, @EndDate, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAProgram(nolock)
		where HOPWAID = @HOPWAID 
			and Program = @Program
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAProgram]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAProgram
go

create procedure dbo.UpdateHOPWAProgram
(
	@HOPWAProgramID	int, 
	@Program	int, 
	@Fund		int, 
	@Yr1		bit, 
	@Yr2		bit, 
	@Yr3		bit, 
	@StartDate	date, 
	@EndDate	date, 
	@Notes			nvarchar(max),
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAProgram set  Program = @Program, Fund = @Fund, Yr1 = @Yr1, Yr2 = @Yr2, Yr3 = @Yr3, 
		StartDate = @StartDate, EndDate = @EndDate,  Notes = @Notes, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAProgram 
	where HOPWAProgramID = @HOPWAProgramID

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

/* HOPWAExp*/
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAExpList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAExpList
go

create procedure dbo.GetHOPWAExpList
(
	@HOPWAProgramID		int,
	@IsActiveOnly		bit
) as
--GetHOPWAExpList 3, 1
begin transaction

	begin try
	declare @ProgramName nvarchar(250)

	select @ProgramName = lv.description
	from HOPWAProgram hp(nolock)
	join lookupvalues lv(nolock) on hp.Program = lv.TypeID
	where HOPWAProgramID = @HOPWAProgramID

	select HOPWAExpID, @ProgramName ProgramName, Amount, Rent, Mortgage, Utilities, PHPUse, lv.description PHPUseName, convert(varchar(10), Date, 101) Date, 
		DisbursementRecord, hp.RowIsActive
	from HOPWAExp hp(nolock) 
	left join lookupvalues lv(nolock) on hp.PHPUse = lv.TypeID
	where HOPWAProgramID = @HOPWAProgramID 
		and (@IsActiveOnly = 0 or hp.RowIsActive = @IsActiveOnly)
		order by hp.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAExpById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAExpById
go

create procedure dbo.GetHOPWAExpById
(
	@HOPWAExpID		int
) as
--GetHOPWAExpById 1
begin transaction

	begin try

	select HOPWAExpID, HOPWAProgramID, convert(varchar(10), Amount) Amount, Rent, Mortgage, Utilities, PHPUse, 
		convert(varchar(10), Date, 101) Date, DisbursementRecord, RowIsActive, DateModified
	from HOPWAExp hp(nolock) 
	where HOPWAExpID = @HOPWAExpID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAExp]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAExp
go

create procedure dbo.AddHOPWAExp
(
	@HOPWAProgramID	int,
	@Amount			decimal(18, 2),
	@Rent			bit,
	@Mortgage		bit, 
	@Utilities		bit, 
	@PHPUse			int, 
	@Date			date, 
	@DisbursementRecord	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from HOPWAExp(nolock)
		where HOPWAProgramID = @HOPWAProgramID 
			and 1 = 2
    )
	begin
		insert into HOPWAExp(HOPWAProgramID, Amount, Rent, Mortgage, Utilities, PHPUse, Date, DisbursementRecord)
		values(@HOPWAProgramID, @Amount, @Rent, @Mortgage, @Utilities, @PHPUse, @Date, @DisbursementRecord)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAExp(nolock)
		where HOPWAProgramID = @HOPWAProgramID 
			and 1 = 2
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAExp]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAExp
go

create procedure dbo.UpdateHOPWAExp
(
	@HOPWAExpID	int, 
	@Amount			decimal(18, 2),
	@Rent			bit,
	@Mortgage		bit, 
	@Utilities		bit, 
	@PHPUse			int, 
	@Date			date, 
	@DisbursementRecord	int,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update HOPWAExp set  Amount = @Amount, Rent = @Rent, 
		Mortgage = @Mortgage, Utilities = @Utilities, PHPUse = @PHPUse, Date = @Date, DisbursementRecord = @DisbursementRecord,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from HOPWAExp 
	where HOPWAExpID = @HOPWAExpID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectCheckReqDates]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectCheckReqDates
go

create procedure dbo.GetProjectCheckReqDates
(
	@ProjectId		int
) as
--GetProjectCheckReqDates 6530
begin transaction

	begin try
	select top 3 ProjectCheckReqID, convert(varchar(10), CRDate, 101) CRDate
	from ProjectCheckReq 
	where projectid = @ProjectId 
	order by CRDate desc

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