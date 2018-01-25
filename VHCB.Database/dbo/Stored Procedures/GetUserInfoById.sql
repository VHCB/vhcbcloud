CREATE procedure GetUserInfoById
(  
 @UserId int 
)  
as  
begin  
 
	select Fname, Lname, Username, password, email, question1, Answer1, DfltPrg, securityLevel, IsFirstTimeUser, NumbProj, HostSite, RowIsActive
	from UserInfo(nolock)
	where UserId = @UserId

end