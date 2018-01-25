
CREATE procedure [dbo].[GetUserSecurityGroup]
as
Begin
	select usergroupid, userGroupName  from UserSecurityGroup where rowisactive = 1
end