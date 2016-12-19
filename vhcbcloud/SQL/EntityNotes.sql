use VHCB
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEntityNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEntityNotes
go

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEntityNotes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEntityNotes
go

create procedure dbo.UpdateEntityNotes
(
	@EntityNotesID int,
	@LkCategory		int, 
	@Notes			nvarchar(max),
	@URL			nvarchar(1500),
	@RowIsActive	bit
)
as
begin transaction

	begin try
		update EntityNotes set LkCategory = @LkCategory, Notes = @Notes, URL = @URL, RowIsActive = @RowIsActive, DateModified = getdate()
		from EntityNotes 
		where EntityNotesID = @EntityNotesID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntityNotesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEntityNotesList
go

create procedure dbo.GetEntityNotesList
(
	@EntityID		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEntityNotesList 1, 1
	begin try
	
		select EntityNotesID, LkCategory, lv.description, pn.UserId, ui.username, convert(varchar(10), Date, 101) as Date, 
			substring(Notes, 0, 25) Notes, Notes as FullNotes, pn.URL, 
			CASE when isnull(pn.URL, '') = '' then '' else 'Click here' end as URLText,
			pn.RowIsActive
		from EntityNotes pn(nolock)
		join lookupvalues lv(nolock) on lv.Typeid = LkCategory
		left join userinfo ui(nolock) on ui.userid = pn.UserId
		where EntityID = @EntityID and (@IsActiveOnly = 0 or pn.RowIsActive = @IsActiveOnly)
		order by EntityNotesID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEntityNotesById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEntityNotesById
go

create procedure dbo.GetEntityNotesById
(
	@EntityNotesID int
)
as
begin transaction
--exec GetProjectNotesById 4
	begin try
	
		select EntityID, LkCategory as LKProjCategory, UserId, Date, Notes, URL, RowIsActive
		from EntityNotes pn(nolock)
		where EntityNotesID = @EntityNotesID

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
