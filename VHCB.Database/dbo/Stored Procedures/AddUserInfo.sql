CREATE procedure AddUserInfo  
(  
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
  
	declare @Username		varchar(100)  
	declare @ProjNum		int
	declare @AppNameID	int

	set @Username = lower(left(@Fname, 1) + @Lname) 

	select @ProjNum = Project_id from project_v where proj_num = @NumbProj
	select @AppNameID = appnameid from Appname(nolock) where ApplicantName = @HostSite

	insert into UserInfo( Fname, Lname, Username, password, email, DfltPrg, securityLevel, NumbProj, HostSite) 
	values ( @Fname, @Lname, @Username, @password, @email, @DfltPrg, @dfltSecGrp, @ProjNum, @AppNameID)  
end