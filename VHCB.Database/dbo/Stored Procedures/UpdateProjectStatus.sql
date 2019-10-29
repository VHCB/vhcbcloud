
create procedure dbo.UpdateProjectStatus
(
	@ProjectStatusId	int,
	@LKProjStatus		int,
	@StatusDate			DateTime, 
	@isActive			bit
) as
begin transaction

	begin try

	update ProjectStatus set LKProjStatus = @LKProjStatus,  StatusDate = @StatusDate, RowIsActive = @isActive
	where ProjectStatusId = @ProjectStatusId

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