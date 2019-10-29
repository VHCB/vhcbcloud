
create procedure dbo.AddEntityNotes
(
	@EntityId	int,
	@UserName	nvarchar(100),
	@Lkcategory int, 
	@Notes		nvarchar(max),
	@URL		nvarchar(1500)
)
as
begin transaction

	begin try

		declare @UserId int
		
		select @UserId = UserId 
		from UserInfo(nolock) 
		where  rtrim(ltrim(Username)) = @UserName 

		insert into EntityNotes(EntityID, LkCategory, UserID, Notes, URL)
		values(@EntityID, @LkCategory, @UserID, @Notes, @URL)

	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
		RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;