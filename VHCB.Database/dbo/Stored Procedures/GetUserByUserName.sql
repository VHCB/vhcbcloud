
create procedure GetUserByUserName
(
	@username varchar(50)
)
as 
Begin
	select userid,  Lname + ', ' + Fname as fullname from UserInfo where Username=@username
End