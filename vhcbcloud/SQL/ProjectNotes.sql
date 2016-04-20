use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectNotes
go

create procedure dbo.AddProjectNotes
(
	@ProjectId	int,
	@UserId		int,
	@Lkcategory int, 
	@Date		DateTime,
	@Notes		nvarchar(max)
)
as
begin transaction

	begin try
	
		insert into ProjectNotes(ProjectId,  LkProjNotes, UserId, Date, Notes)
		values(@ProjectId, @Lkcategory, @UserId, @Date, @Notes)

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
	@LkCategory int, 
	@Notes		nvarchar(max)
)
as
begin transaction

	begin try
	
		update ProjectNotes set LkProjNotes = @LkCategory, Notes = @Notes, DateModified = getdate()
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
	@ProjectId int
)
as
begin transaction

	begin try
	
		select ProjectNotesID, LkProjNotes, lv.description, pn.UserId, ui.username, convert(varchar(10), Date, 101) as Date, 
			substring(Notes, 0, 25) Notes, Notes as FullNotes
		from ProjectNotes pn(nolock)
		join lookupvalues lv(nolock) on lv.Typeid = LkProjNotes
		left join userinfo ui(nolock) on ui.userid = pn.UserId
		where ProjectId = @ProjectId
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
	
		select ProjectId, LkProjNotes as LKProjCategory, UserId, Date, Notes
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




