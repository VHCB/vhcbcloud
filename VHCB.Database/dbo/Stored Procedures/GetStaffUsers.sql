
CREATE procedure [dbo].[GetStaffUsers]
as
Begin
	select userid, Lname + ', '+Fname as name from userinfo order by lname
	
End