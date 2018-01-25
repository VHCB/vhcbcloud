create procedure SetPassword
(
	@Username			varchar(100),
	@NewPassword		varchar(40)
)
as
begin
--exec SetPassword 'aduffy', 'Vhcb123!'

	update UserInfo set password = @NewPassword, IsFirstTimeUser = 0 where Username = @Username 

end