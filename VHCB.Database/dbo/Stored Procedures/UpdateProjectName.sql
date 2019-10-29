
create procedure dbo.UpdateProjectName
(
	@ProjectId		int,
	@TypeId			int,
	@ProjectName	varchar(70),
	@DefName		bit,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update lookupvalues set description = @projectName, RowIsActive = @RowIsActive
	where TypeId = @TypeId

	if(@DefName = 1 and @RowIsActive = 1)
	begin
	 update ProjectName set DefName = 0 where ProjectId = @ProjectId
	end

	if(@RowIsActive = 1)
	begin
		update ProjectName set DefName = @DefName, DateModified = getdate()
		where LKProjectName = @TypeId and ProjectId = @ProjectId
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