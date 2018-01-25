CREATE procedure GetUserFxnSecurity
(
	@userid int
)
as
Begin

	select  distinct UserFxnSecurityId, FxnID, ui.UserID,
	 (ui.LNAME+', '+ui.FNAME) as username, 		
		lv.Description as FxnSecurity	
		from UserFxnSecurity ufs 
		join LookupValues lv(nolock) on lv.TypeID = FxnID
		join UserInfo ui(nolock) on ui.UserId = ufs.Userid
	where ui.UserID = @userid and ufs.RowIsActive = 1
End