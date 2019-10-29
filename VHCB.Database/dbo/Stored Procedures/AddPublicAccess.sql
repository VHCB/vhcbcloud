
create procedure dbo.AddPublicAccess
(
	@ConserveID		int,
	@LkPAccess	int,
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
		from ConservePAccess(nolock)
		where ConserveID = @ConserveID 
			and LkPAccess = @LkPAccess
    )
	begin
		insert into ConservePAccess(ConserveID, LkPAccess, DateModified)
		values(@ConserveID, @LkPAccess, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConservePAccess(nolock)
		where ConserveID = @ConserveID 
			and LkPAccess = @LkPAccess
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