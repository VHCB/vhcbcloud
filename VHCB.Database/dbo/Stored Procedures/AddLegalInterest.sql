
create procedure dbo.AddLegalInterest
(
	@ConserveID		int,
	@LKLegInterest	int,
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
		from ConserveLegInterest(nolock)
		where ConserveID = @ConserveID 
			and LKLegInterest = @LKLegInterest
    )
	begin
		insert into ConserveLegInterest(ConserveID, LKLegInterest, DateModified)
		values(@ConserveID, @LKLegInterest, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ConserveLegInterest(nolock)
		where ConserveID = @ConserveID 
			and LKLegInterest = @LKLegInterest
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