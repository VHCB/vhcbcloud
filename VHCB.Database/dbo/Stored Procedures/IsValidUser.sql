CREATE procedure IsValidUser
(
	@Username			varchar(100),
	@Password			varchar(40),
	@ReturnData			varchar(5) output
)
as
begin
--exec IsValidUser 'aduffy', 'Vhcb123!', ''

	declare @IsValidUser bit, @IsFirstTimeUser bit, @userid int

	if exists(select 1 from UserInfo(nolock) where Username = @Username and password = @password)
		select @IsValidUser = 1, @IsFirstTimeUser = IsFirstTimeUser, @userid = userid from UserInfo(nolock) where Username = @Username and password = @password
	else
		select @IsValidUser = 0, @IsFirstTimeUser = 0, @userid = 0

	select @ReturnData = convert(varchar(1), @IsValidUser) + '|' + convert(varchar(1), @IsFirstTimeUser ) + '|' + convert(varchar(10), @userid)
end