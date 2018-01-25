
create procedure dbo.AddProjectVHCBPriorities
( 
	@ProjectID			int,
	@LkVHCBPriorities	int,
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
		from ProjectVHCBPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkVHCBPriorities = @LkVHCBPriorities
    )
	begin
		insert into ProjectVHCBPriorities(ProjectID, LkVHCBPriorities, DateModified)
		values(@ProjectID, @LkVHCBPriorities, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectVHCBPriorities(nolock)
		where ProjectID = @ProjectID 
			and LkVHCBPriorities = @LkVHCBPriorities
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