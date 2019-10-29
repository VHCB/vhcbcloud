CREATE procedure UpdateUserInfo  
(  
	@userid		int,  
	@Fname		varchar(40),   
	@Lname		varchar(50),   
	@password	varchar(40),   
	@email		varchar(150),  
	@DfltPrg	int,
	@dfltSecGrp int,
	@NumbProj	varchar(15)	= null,
	@HostSite	varchar(50) = null
)  
as  
begin  
  
	declare @Username	varchar(100)  
	declare @ProjNum	int
	declare @AppNameID	int

	set @Username = lower(left(@Fname, 1) + @Lname)

	select top 1 @ProjNum =  Project_id from project_v where proj_num = @NumbProj
	select @AppNameID = appnameid from Appname(nolock) where ApplicantName = @HostSite

	set @ProjNum = 6606
	update UserInfo set Fname = @Fname, Lname = @Lname, Username = @Username, email = @email, password = @password, DfltPrg = @DfltPrg,
	securityLevel = @dfltSecGrp, NumbProj = @ProjNum, HostSite = @AppNameID
	where userid = @userid  
   
end