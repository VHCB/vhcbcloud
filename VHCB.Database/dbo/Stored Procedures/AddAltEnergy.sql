
create procedure dbo.AddAltEnergy
(
	@ConserveID		int,
	@LkAltEnergy	int,
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
		from ConserveAltEnergy(nolock)
		where ConserveID = @ConserveID 
			and LkAltEnergy = @LkAltEnergy
    )
	begin
		insert into ConserveAltEnergy(ConserveID, LkAltEnergy, DateModified)
		values(@ConserveID, @LkAltEnergy, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAltEnergy(nolock)
		where ConserveID = @ConserveID 
			and LkAltEnergy = @LkAltEnergy
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