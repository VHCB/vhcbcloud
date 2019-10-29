CREATE procedure GetuserPageSecurity
(
	@userid int
)
as
Begin
	select distinct ups.PageSecurityId, ui.userid,  (ui.LNAME+', '+ui.FNAME) as username, 		
		(select description from LookupValues where typeid = ups.pageid) pagedesc		
		from UserPageSecurity ups join UserInfo ui on ui.UserId = ups.Userid
	where ui.UserId = @userid
End