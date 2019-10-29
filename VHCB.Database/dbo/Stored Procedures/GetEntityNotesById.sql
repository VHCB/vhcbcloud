
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