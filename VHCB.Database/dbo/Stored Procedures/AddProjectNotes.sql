
create procedure dbo.AddProjectNotes
(
	@ProjectId	int,
	@UserName	nvarchar(100),
	@Lkcategory int, 
	@Date		DateTime,
	@Notes		nvarchar(max),
	@URL		nvarchar(1500),
	@pcrid		int = null,
	@PageId		int = null
)
as
begin transaction

	begin try

		declare @UserId int
		
		select @UserId = UserId 
		from UserInfo(nolock) 
		where  rtrim(ltrim(Username)) = @UserName 

		insert into ProjectNotes(ProjectId,  LkCategory, UserId, Date, Notes, URL,ProjectCheckReqID, PageId)
		values(@ProjectId, @Lkcategory, @UserId, @Date, @Notes, @URL, @pcrid, @PageId)

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