CREATE procedure dbo.UpdateRelatedProject
(
	@ProjectId			int,
	@RelProjectId		int,
	@DualGoal			bit,
	@RowIsActive		bit

) as
begin transaction

	begin try

	update projectrelated set RowIsActive = @RowIsActive, DualGoal = @DualGoal
	where  ProjectID = @ProjectID and RelProjectId = @RelProjectId

	update projectrelated set RowIsActive = @RowIsActive, DualGoal = @DualGoal
	where  ProjectID = @RelProjectId and RelProjectId = @ProjectID

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