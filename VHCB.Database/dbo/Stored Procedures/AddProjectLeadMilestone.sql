CREATE procedure dbo.AddProjectLeadMilestone
(
	@ProjectID		int, 
	@LKMilestone	int, 
	@LeadBldgID		int, 
	@LeadUnitID		int, 
	@MSDate			datetime,
	@URL			nvarchar(1500),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    ( 
		select 1 
		from ProjectLeadMilestone (nolock)
		where ProjectID = @ProjectID and LKMilestone = @LKMilestone
	)
	begin
		insert into ProjectLeadMilestone(ProjectID, LKMilestone, LeadBldgID, LeadUnitID, MSDate, URL)
		values(@ProjectID, @LKMilestone, @LeadBldgID, @LeadUnitID, @MSDate, @URL)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectLeadMilestone (nolock)
		where ProjectID = @ProjectID and LKMilestone = @LKMilestone
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