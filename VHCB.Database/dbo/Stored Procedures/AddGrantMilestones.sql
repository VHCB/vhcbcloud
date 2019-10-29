
create procedure dbo.AddGrantMilestones
(
	@GrantInfoID	int, 
	@MilestoneID	int, 
	@Date			datetime,
	@Note			nvarchar(max), 
	@URL			nvarchar(1500)
) as
begin transaction

	begin try

		insert into GrantMilestones(GrantInfoID, MilestoneID, Date, Note, URL)
		values(@GrantInfoID, @MilestoneID, @Date, @Note, @URL)

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