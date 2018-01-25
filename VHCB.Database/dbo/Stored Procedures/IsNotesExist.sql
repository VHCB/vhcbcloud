
create procedure dbo.IsNotesExist
(
	@PageId			int,
	@ProjectId		int = null,
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