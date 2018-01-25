
create procedure dbo.UpdateConsolidatedPlanPriorities
(
	@ProjectConPlanPrioritiesID	int,
	@UserID						int,
	@RowIsActive				bit
) as
begin transaction

	begin try
	
	update ProjectConPlanPriorities set RowIsActive = @RowIsActive, UserID = @UserID, DateModified = getdate()
	from ProjectConPlanPriorities 
	where ProjectConPlanPrioritiesID = @ProjectConPlanPrioritiesID

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