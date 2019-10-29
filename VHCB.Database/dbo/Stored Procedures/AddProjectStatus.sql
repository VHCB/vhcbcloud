
create procedure dbo.AddProjectStatus
(
	@ProjectId			int,
	@LKProjStatus		int,
	@StatusDate			datetime
) as
begin transaction

	begin try

	insert into ProjectStatus(ProjectID, LKProjStatus, StatusDate)
	values(@ProjectID, @LKProjStatus, @StatusDate)

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