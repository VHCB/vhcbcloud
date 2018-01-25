CREATE procedure dbo.AddRelatedProject
(
	@ProjectId			int,
	@RelProjectId		int,
	@isDuplicate		bit output,
	@isActive			bit Output

) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	 if not exists
        (
			select 1
			from projectrelated(nolock)
			where ProjectID = @ProjectId and RelProjectID = @RelProjectId
        )
		begin
			insert into projectrelated(ProjectID, RelProjectID)
			values(@ProjectId, @RelProjectId)

			insert into projectrelated(ProjectID, RelProjectID)
			values(@RelProjectId, @ProjectId)

			set @isDuplicate = 0
		end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from projectrelated(nolock)
			where ProjectID = @ProjectId and RelProjectID = @RelProjectId
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