CREATE procedure AddUserPageSecurity
(
	@userid int,
	@pageid int
	
)
as 
Begin
	insert into UserPageSecurity(userid,pageid)
	values (@userid, @pageid)
end