CREATE procedure AddUserFxnSecurity
(
	@userid int,
	@FxnID int
	
)
as 
Begin
	insert into UserFxnSecurity(userid, FxnID)
	values (@userid, @FxnID)
end