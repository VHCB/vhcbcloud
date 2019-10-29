
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