CREATE procedure GetUsersUserSecurityGroup
as
Begin

	select ui.userid,  (ui.LNAME+', '+ui.FNAME) as Name, usg.usergroupname, uus.usergroupid,uus.UsersUserSecurityGrpId
	from UserInfo ui join UsersUserSecurityGroup uus on uus.userid = ui.userid
	join UserSecurityGroup usg on uus.UserGroupId = usg.UserGroupId
	where ui.rowisactive = 1

end