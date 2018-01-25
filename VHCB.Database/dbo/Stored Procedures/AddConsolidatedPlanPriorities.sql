
create procedure dbo.AddConsolidatedPlanPriorities
(
	@ProjectID				int,
	@LkConplanPriorities	int,
	@UserID					int,
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
		from ProjectConPlanPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkConplanPriorities = @LkConplanPriorities
    )
	begin
		insert into ProjectConPlanPriorities(ProjectID, LkConplanPriorities, UserID, DateModified)
		values(@ProjectID, @LkConplanPriorities, @UserID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectConPlanPriorities(nolock)
		where ProjectID = @ProjectID
			and LkConplanPriorities = @LkConplanPriorities
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