CREATE procedure GetUserInfoById
(  
 @UserId int 
)  
as  
begin  
 -- exec GetUserInfoById 66
	declare @ProjNumber	varchar(15)
	declare @ApplicantName	varchar(50)
	declare @NumbProj int
	declare @HostSite int

	select  @NumbProj = NumbProj, @HostSite = HostSite
	from UserInfo(nolock)
	where UserId = @UserId

	select @ProjNumber = isnull(proj_num, '') from project_v where Project_id = @NumbProj
	select @ApplicantName = isnull(ApplicantName, '') from Appname(nolock) where appnameid = @HostSite

	select Fname, Lname, Username, password, email, question1, Answer1, DfltPrg, securityLevel, IsFirstTimeUser, NumbProj, HostSite, RowIsActive, isnull(@ProjNumber, '') ProjeNumber, isnull(@ApplicantName, '') ApplicantName
	from UserInfo(nolock)
	where UserId = @UserId

end