create procedure DeleteUserFxnSecurity
(
	@UserFxnSecurityId int
)
as
Begin
	Delete from UserFxnSecurity where UserFxnSecurityId = @UserFxnSecurityId
End