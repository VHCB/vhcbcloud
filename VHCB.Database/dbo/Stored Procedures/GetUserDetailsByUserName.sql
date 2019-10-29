
CREATE procedure GetUserDetailsByUserName
@username varchar(50)
as
Begin

-- exec GetUserDetailsByUserName 'aduffy'
 SELECT UserId
		,FName
		,LName
		,email
		,NumbProj
		,isnull(HostSite,0) as Hostsite
 from UserInfo
 where Username=@username
end