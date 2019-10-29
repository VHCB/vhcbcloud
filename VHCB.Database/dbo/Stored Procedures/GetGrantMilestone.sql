
create procedure GetGrantMilestone  
(
	@MilestoneGrantID	int
)
as
begin
--exec GetGrantMilestone 1
	begin try

		select MilestoneGrantID, GrantInfoID, MilestoneID, Date, Note, URL, RowIsActive
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
end