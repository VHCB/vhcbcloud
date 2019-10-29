CREATE procedure GetUserSecurityByUserId
(
	@userid int
)
as
Begin
select ui.userid,  (ui.LNAME+', '+ui.FNAME) as Name, ui.dfltprg, usg.usergroupname, usg.UserGroupId
 from UserInfo ui join UserSecurityGroup usg on ui.securityLevel = usg.UserGroupId  
 where ui.rowisactive = 1 and ui.userid = @userid  
end