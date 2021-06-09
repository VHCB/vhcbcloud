use PTConvert
go


--delete from vhcb.dbo.HOPWAProgram
--truncate table vhcb.dbo.HOPWAEthnic
--truncate table vhcb.dbo.HOPWARace
--truncate table vhcb.dbo.HOPWAAge
--truncate table vhcb.dbo.HOPWAEXP
--delete from vhcb.dbo.HOPWAmaster
--DBCC CHECKIDENT ('vhcb.dbo.HOPWAmaster', RESEED, 0);
--GO
--DBCC CHECKIDENT ('vhcb.dbo.HOPWAProgram', RESEED, 0);
--GO

--select * from vhcb.dbo.HOPWAmaster
--select * from vhcb.dbo.HOPWAProgram
--select * from vhcb.dbo.HOPWAEthnic
--select * from vhcb.dbo.HOPWARace
--select * from vhcb.dbo.HOPWAAge
--select * from vhcb.dbo.HOPWAEXP

DECLARE @HOPWAID int, @ProjectId int, @UUID nvarchar(255), @StartDate nvarchar(50), @Yr1 float, @Yr2 float, @Yr3 float, @PrimaryASO int,
@Primary_ASO nvarchar(255), @Primary_ASO_code nvarchar(10),
@RecentLivingSituation nvarchar(255), @livingsituationID nvarchar(10), @withHIV float, 
@InHousehold float, @Minors float, @HHGender nvarchar(255), @HHAge float, @HHEthnic float, @HHRace nvarchar(255), @Hispanic float, 
@Non_Hisp float, @Asian nvarchar(255), @Native nvarchar(255), @Black float, @White float, @Other float, @Special_Needs nvarchar(255), 
@GMI money, @AMI float, @Beds float, @RetainedHsg nvarchar(255), @AppliedSec8 nvarchar(255), @PreferenceStatus nvarchar(255),
@F17 int, @M17 int, @F30 int, @M30 int, @F50 int, @M50 int, @F51 int, @M51 int, @PrevHOPWAID int, @HOPWAProgramID int,
@Rent bit, @Mortgage bit, @Utilities bit, @HHincludes nvarchar(10),  @Use_code int, @Amount money


declare NewCursor Cursor for
select Primary_ASO_code as ProjectId, UUID, 
	case Primary_ASO_code when 7242 then 1021 when 7243  then 1022 when 7244 then 1036 when 7241 then 961 end as PrimaryASO,
	null as StartDate, Yr1, Yr2, isnull(yr3, 0) as Yr3, Primary_ASO, Primary_ASO_code, [Recent Living Situation] as RecentLivingSituation,
	RLS_code as livingsituationID, withHIV, InHousehold, 
	isnull(Minors, 0) as Minors, [HH Gender] as HHGender, [HH Age] as HHAge, [HH Ethnic] as HHEthnic, [HH Race] as HHRace, isnull(Hispanic, 0) as Hispanic, 
	isnull(Non_Hisp, 0) as Non_Hisp, isnull(Asian, 0) as Asian, isnull(Native, 0) as Native, 
	isnull(Black, 0) as Black, isnull(White, 0) as White,
	isnull(Other, 0) as Other, Special_Needs, 
	GMI, [% AMI] AMI, Beds, null as RetainedHsg, null as AppliedSec8 , null as PreferenceStatus,
	[0-17 F] as F17, [0-17 M] as M17, [18-30 F] as F30, [18-30 M] as M30, [31-50 F] as F50, [31-50 M] as M50, [51+ F] as F51, [51+ M] as M51,
	0 as PrevHOPWAID,  --PreviousID as PrevHOPWAID, 
	0 as Rent, 0 as Mortgage, 0 as Utilities, null as HHincludes,
	Use_code, Amount
from [dbo].[MasterProj_2] mp
join dbo.HOPWA_PHP_8 ra8(nolock) on mp.ProjectId = ra8.Primary_ASO_code

	open NewCursor
	fetch next from NewCursor into @ProjectId, @UUID, @PrimaryASO, @StartDate, @Yr1, @Yr2, @Yr3, @Primary_ASO, @Primary_ASO_code, @RecentLivingSituation, 
	@livingsituationID, @withHIV, 
	@InHousehold, @Minors, @HHGender, @HHAge, @HHEthnic, @HHRace, @Hispanic, 
	@Non_Hisp, @Asian, @Native, @Black, @White, @Other, @Special_Needs, 
	@GMI, @AMI, @Beds, @RetainedHsg, @AppliedSec8, @PreferenceStatus,
	@F17, @M17, @F30, @M30, @F50, @M50, @F51, @M51,
	@PrevHOPWAID, @Rent, @Mortgage, @Utilities, @HHincludes,
	@Use_code, @Amount
	WHILE @@FETCH_STATUS = 0
	begin

	set @HOPWAID = 0
	select @HOPWAID = HOPWAID from vhcb.dbo.HOPWAmaster where ProjectID = @ProjectID and UUID = @UUID

	if(@HOPWAID = 0)
	begin
		insert into vhcb.dbo.HOPWAmaster(ProjectID, UUID, HHincludes, WithHIV, InHousehold, Minors, Gender, Age, Ethnic, Race, 
		LivingSituationId, SpecNeeds, GMI, AMI, Beds, Notes, PrimaryASO, PrevHOPWAID)
		select @ProjectId, @UUID, null, @withHIV, @InHousehold, @Minors, @HHGender, @HHAge, @HHEthnic, @HHRace, 
		@livingsituationID, @Special_Needs, @GMI, @AMI, @Beds, @PreferenceStatus, @PrimaryASO, @PrevHOPWAID

		set @HOPWAID =  SCOPE_IDENTITY()
	end

	insert into vhcb.dbo.HOPWAProgram(HOPWAID, Program, Fund, LivingSituationId, Yr1, Yr2, Yr3, StartDate, EndDate, Notes)
	select @HOPWAID, 26778, 201, @livingsituationID, @Yr1, @Yr2, @Yr3, @StartDate, null, null

	set @HOPWAProgramID =  SCOPE_IDENTITY()

	--HOPWAEthnic
	insert into vhcb.dbo.HOPWAEthnic(HOPWAID, Ethnic, EthnicNum)
	select @HOPWAID, @HHEthnic, @Hispanic where @Hispanic != 0

	insert into vhcb.dbo.HOPWAEthnic(HOPWAID, Ethnic, EthnicNum)
	select @HOPWAID, @HHEthnic, @Non_Hisp where @Non_Hisp != 0
	
	--HOPWARace
	insert into vhcb.dbo.HOPWARace(HOPWAID, Race, HouseholdNum)
	select @HOPWAID, 47, @Asian where @Asian != 0

	insert into vhcb.dbo.HOPWARace(HOPWAID, Race, HouseholdNum)
	select @HOPWAID, 48, @Native where @Native != 0

	insert into vhcb.dbo.HOPWARace(HOPWAID, Race, HouseholdNum)
	select @HOPWAID, 46, @Black where @Black != 0

	insert into vhcb.dbo.HOPWARace(HOPWAID, Race, HouseholdNum)
	select @HOPWAID, 45, @White where @White != 0

	insert into vhcb.dbo.HOPWARace(HOPWAID, Race, HouseholdNum)
	select @HOPWAID, 26131, @Other where @Other != 0

	--HOPWAAge
	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26641, @F17 where @F17 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26642, @M17 where @M17 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26643, @F30 where @F30 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26644, @M30 where @M30 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26645, @F50 where @F50 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26646, @M50 where @M50 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26647, @F51 where @F51 != 0

	insert into vhcb.dbo.HOPWAAge(HOPWAID, GenderAgeID, GANum)
	select @HOPWAID, 26648, @M51 where @M51 != 0
	
	--HOPWAExp
	insert into vhcb.dbo.HOPWAExp(HOPWAProgramID, Fund, TransType, Amount, Rent, Mortgage, Utilities, PHPUse)
	select @HOPWAProgramID, 201, null, 0,  @Rent, @Mortgage, @Utilities, @Use_code

	FETCH NEXT FROM NewCursor INTO @ProjectId, @UUID, @PrimaryASO, @StartDate, @Yr1, @Yr2, @Yr3, @Primary_ASO, @Primary_ASO_code, @RecentLivingSituation, 
	@livingsituationID, @withHIV, 
	@InHousehold, @Minors, @HHGender, @HHAge, @HHEthnic, @HHRace, @Hispanic, 
	@Non_Hisp, @Asian, @Native, @Black, @White, @Other, @Special_Needs, 
	@GMI, @AMI, @Beds, @RetainedHsg, @AppliedSec8, @PreferenceStatus,
	@F17, @M17, @F30, @M30, @F50, @M50, @F51, @M51,
	@PrevHOPWAID, @Rent, @Mortgage, @Utilities, @HHincludes,
	@Use_code, @Amount

	end

Close NewCursor
deallocate NewCursor

	