
create procedure dbo.AddLegalMechanism
(
	@ConserveID		int,
	@LKLegMech		int,
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
		from ConserveLegMech(nolock)
		where ConserveID = @ConserveID 
			and LKLegMech = @LKLegMech
    )
	begin
		insert into ConserveLegMech(ConserveID, LKLegMech, DateModified)
		values(@ConserveID, @LKLegMech, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveLegMech(nolock)
		where ConserveID = @ConserveID 
			and LKLegMech = @LKLegMech
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