
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