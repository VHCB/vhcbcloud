CREATE procedure dbo.GetProjectNotesList
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