alter procedure GetUserInfo
as
begin
--exec GetUserInfo

	select userid, Fname, Lname, Username, password, email from UserInfo(nolock) order by DateModified desc 
end
go

alter procedure AddUserInfo
(
	@Fname		varchar(40), 
	@Lname		varchar(50), 
	@password	varchar(40), 
	@email		varchar(150)
)
as
begin

	declare @Username	varchar(100)

	set @Username = lower(left(@Fname, 1) + @Lname)

	insert into UserInfo(usergroupid, Fname, Lname, Username, password, email) values (0, @Fname, @Lname, @Username, @password, @email)
end
go

alter procedure UpdateUserInfo
(
	@userid		int,
	@Fname		varchar(40), 
	@Lname		varchar(50), 
	@password	varchar(40), 
	@email		varchar(150)
)
as
begin

	declare @Username	varchar(100)

	set @Username = lower(left(@Fname, 1) + @Lname)

	update UserInfo set Fname = @Fname, Lname = @Lname, Username = @Username, email = @email, password = @password
	where userid = @userid
	
end
go

alter procedure GetFundTypeDescription
(
	@fundTypedesc varchar(150)	
)
as 
Begin
	select lkf.Description from lkfundtype  lkf join LookupValues lkv on lkv.TypeID = lkf.LkSource
	where lkv.LookupType = 40 and lkf.Description like @fundTypedesc +'%'  order by lkf.Description 

end