create procedure GetUserInfo
as
begin
--exec GetUserInfo

	select userid, Fname, Lname, Username, password, email from UserInfo(nolock)
end
go

create procedure AddUserInfo
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

create procedure UpdateUserInfo
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

--select * from UserInfo
