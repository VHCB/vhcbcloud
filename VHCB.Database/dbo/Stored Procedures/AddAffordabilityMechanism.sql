
create procedure dbo.AddAffordabilityMechanism
(
	@ConserveID		int,
	@LkConsAffMech	int,
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
		from ConserveAffMech(nolock)
		where ConserveID = @ConserveID 
			and LkConsAffMech = @LkConsAffMech
    )
	begin
		insert into ConserveAffMech(ConserveID, LkConsAffMech, DateModified)
		values(@ConserveID, @LkConsAffMech, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveAffMech(nolock)
		where ConserveID = @ConserveID 
			and LkConsAffMech = @LkConsAffMech
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