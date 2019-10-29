CREATE procedure AddUsersToSecurityGroup
(
	@userid int,
	@usergroupid int
)
as
Begin
	insert into UsersUserSecurityGroup (userid, usergroupid) 
		values (@userid, @usergroupid)
End