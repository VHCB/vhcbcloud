
create procedure dbo.UpdateGrantMilestones
(
	@MilestoneGrantID int,
	@MilestoneID	int, 
	@Date			datetime,
	@Note			nvarchar(max), 
	@URL			nvarchar(1500),
	@RowIsActive	bit
)
as
begin transaction

	begin try
	
		update GrantMilestones set MilestoneID = @MilestoneID, Note = @Note, URL = @URL, RowIsActive = @RowIsActive, DateModified = getdate()
		from GrantMilestones 
		where MilestoneGrantID = @MilestoneGrantID

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