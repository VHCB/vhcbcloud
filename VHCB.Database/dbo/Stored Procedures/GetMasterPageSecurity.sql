create procedure GetMasterPageSecurity
(
	@userid int
)
as
Begin
	select distinct ui.userid,  (ui.LNAME+', '+ui.FNAME) as username, 
		 case when lv.lookuptype = 193 then lv.Description else '' end 'PageDescription'		
	from UserInfo ui join UserPageSecurity ups on ups.Userid = ui.UserId
		left join LookupValues lv on lv.lookuptype in (193, 194, 195)
	where ui.UserId = @userid
End