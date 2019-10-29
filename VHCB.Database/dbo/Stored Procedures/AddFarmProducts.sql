
create procedure dbo.AddFarmProducts
(
	@FarmId				int,
	@LkProductCrop		int,
	@StartDate			datetime,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from FarmProducts(nolock)
		where FarmId = @FarmId 
			and LkProductCrop = @LkProductCrop
    )
	begin
		insert into FarmProducts(FarmId, LkProductCrop, StartDate, DateModified)
		values(@FarmId, @LkProductCrop, @StartDate, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from FarmProducts(nolock)
		where FarmId = @FarmId 
			and LkProductCrop = @LkProductCrop
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