use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectNotes
go

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectNotes
go

create procedure dbo.UpdateProjectNotes
(
	@ProjectNotesID int,
	@LkCategory		int, 
	@Notes			nvarchar(max),
	@URL			nvarchar(1500),
	@RowIsActive	bit
)
as
begin transaction

	begin try
	
		update ProjectNotes set LkCategory = @LkCategory, Notes = @Notes, URL = @URL, RowIsActive = @RowIsActive, DateModified = getdate()
		from ProjectNotes 
		where ProjectNotesID = @ProjectNotesID

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectNotesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectNotesList
go

create procedure dbo.GetProjectNotesList
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetProjectNotesList 1, 1
	begin try
	
		select ProjectNotesID, LkCategory, lv.description, pn.UserId, ui.username, convert(varchar(10), Date, 101) as Date, 
			substring(Notes, 0, 25) Notes, Notes as FullNotes, pn.URL, 
			CASE when isnull(pn.URL, '') = '' then '' else 'Click here' end as URLText,
			pn.RowIsActive, pn.PageID 
		from ProjectNotes pn(nolock)
		join lookupvalues lv(nolock) on lv.Typeid = LkCategory
		left join userinfo ui(nolock) on ui.userid = pn.UserId
		where ProjectId = @ProjectId and (@IsActiveOnly = 0 or pn.RowIsActive = @IsActiveOnly)
		order by ProjectNotesID desc
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectNotesById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectNotesById
go

create procedure dbo.GetProjectNotesById
(
	@ProjectNotesId int
)
as
begin transaction
--exec GetProjectNotesById 4
	begin try
	
		select ProjectId, LkCategory as LKProjCategory, UserId, Date, Notes, URL, RowIsActive
		from ProjectNotes pn(nolock)
		where ProjectNotesID = @ProjectNotesId

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
go



if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetPageId]') and type in (N'P', N'PC'))
drop procedure [dbo].GetPageId
go

create procedure dbo.GetPageId
(
	@PageName varchar(50),
	@PageId	  int output
)
as
begin transaction
--exec GetPageId 'ConservationSummary.aspx', null
	begin try
	
		select @PageId = ProgramTabID
		from ProgramTab 
		where PageName = @PageName

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[IsNotesExist]') and type in (N'P', N'PC'))
drop procedure [dbo].IsNotesExist
go

create procedure dbo.IsNotesExist
(
	@PageId			int,
	@ProjectId		int,
	@IsNotesExist	bit output
)
as
begin transaction
--exec IsNotesExist 1, null 
	begin try

	set @IsNotesExist = 1
	if not exists
    (
		select 1
		from ProjectNotes 
		where PageId = @PageId and ProjectId = @ProjectId
    )
	begin
		set @IsNotesExist = 0
	end

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
go