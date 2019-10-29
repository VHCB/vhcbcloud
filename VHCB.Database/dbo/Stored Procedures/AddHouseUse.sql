CREATE procedure dbo.AddHouseUse
(
	@HousingID			int,
	@LKBudgetPeriod		int,
	@LkHouseUseVHCB		int,
	@VHCBTotal			decimal(18, 2),
	@LKHouseUseOther	int,
	@OtherTotal			decimal,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	declare @HouseSUID int

	if not exists
    (
		select 1
		from HouseSU(nolock)
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
    )
	begin

		update HouseSU set MostCurrent = 0 where HousingId = @HousingID and MostCurrent = 1

		insert into HouseSU(HousingID, LKBudgetPeriod, DateModified, MostCurrent)
		values(@HousingID, @LKBudgetPeriod, getdate(), 1)

		set @HouseSUID = @@IDENTITY
	end
	else
	begin
		select @HouseSUID = HouseSUID 
		from HouseSU(nolock) 
		where HousingID = @HousingID 
			and LKBudgetPeriod = @LKBudgetPeriod
	end
	
	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from HouseUse(nolock)
		where HouseSUID = @HouseSUID
			and LkHouseUseVHCB = @LkHouseUseVHCB
    )
	begin
		insert into HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal)
		values(@HouseSUID, @LkHouseUseVHCB, @VHCBTotal, @LKHouseUseOther, @OtherTotal)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HouseUse(nolock)
		where HouseSUID = @HouseSUID
			and LkHouseUseVHCB = @LkHouseUseVHCB
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