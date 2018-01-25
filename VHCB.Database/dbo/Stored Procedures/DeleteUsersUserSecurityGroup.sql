
CREATE procedure DeleteUsersUserSecurityGroup
(
	@UsersUserSecurityGrpId int
)
as
Begin
	Delete from UsersUserSecurityGroup where UsersUserSecurityGrpId = @UsersUserSecurityGrpId
End