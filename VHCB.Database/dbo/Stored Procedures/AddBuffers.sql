
create procedure dbo.AddBuffers
(
	@ConserveID		int,
	@LkBuffer		int,
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
		from ConserveBuffer(nolock)
		where ConserveID = @ConserveID 
			and LkBuffer = @LkBuffer
    )
	begin
		insert into ConserveBuffer(ConserveID, LkBuffer, DateModified)
		values(@ConserveID, @LkBuffer, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveBuffer(nolock)
		where ConserveID = @ConserveID 
			and LkBuffer = @LkBuffer
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