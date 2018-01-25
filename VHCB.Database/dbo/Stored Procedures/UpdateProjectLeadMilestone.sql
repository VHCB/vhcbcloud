CREATE procedure dbo.UpdateProjectLeadMilestone
(
	@LeadMilestoneID	int,
	@LKMilestone		int, 
	@LeadBldgID			int, 
	@LeadUnitID			int, 
	@URL				nvarchar(1500),
	@MSDate				datetime,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectLeadMilestone set LKMilestone = LKMilestone, LeadBldgID = @LeadBldgID, LeadUnitID = @LeadUnitID, MSDate = @MSDate, URL = @URL,
		RowIsActive = @IsRowIsActive
	where LeadMilestoneID = @LeadMilestoneID

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