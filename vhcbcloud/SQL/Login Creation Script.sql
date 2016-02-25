

alter table UserInfo
add IsFirstTimeUser bit default(1)
go

update UserInfo set Username = lower(left(fname, 1)+Lname),
password = 'Vhcb123!', IsFirstTimeUser = 1
from UserInfo
go

create procedure IsValidUser
(
	@Username			varchar(100),
	@Password			varchar(40),
	@ReturnData			varchar(5) output
)
as
begin
--exec IsValidUser 'aduffy', 'Vhcb123!', ''

	declare @IsValidUser bit, @IsFirstTimeUser bit

	if exists(select 1 from UserInfo(nolock) where Username = @Username and password = @password)
		select @IsValidUser = 1, @IsFirstTimeUser = IsFirstTimeUser from UserInfo(nolock) where Username = @Username and password = @password
	else
		select @IsValidUser = 0, @IsFirstTimeUser = 0

	select @ReturnData = convert(varchar(1), @IsValidUser) + '|' + convert(varchar(1), @IsFirstTimeUser)
end
go


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
go

--select * from UserInfo