
create procedure ImportHousingBudgetPeriodData
(
	@ProjectID				int,
	@ImportLKBudgetPeriod	int,
	@LKBudgetPeriod			int
)  
as
/*
exec ImportHousingBudgetPeriodData 6586,26084, 26085


select * from conserve
select * from ConserveSU where conserveid = 3
select * from ConserveSources where ConserveSUId = 7
select * from ConserveUses where ConserveSUId = 7
*/
begin
		declare @HousingID	int
		declare @HouseSUID int
		declare @ImportFromHouseSUID int

		if not exists
		(
			select 1 
			from Housing(nolock) 
			where ProjectID = @ProjectID
		)
		begin
			RAISERROR ('Invalid Import1, No Project exist', 16, 1)
			return 1
		end
		else
		begin
			select @HousingID = HousingID 
			from Housing(nolock) 
			where ProjectID = @ProjectID
		end 

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

		select @ImportFromHouseSUID = HouseSUID 
		from HouseSU(nolock) 
		where HousingID = @HousingID 
			and LKBudgetPeriod = @ImportLKBudgetPeriod

		insert into HouseSource(HouseSUID, LkHouseSource, Total, DateModified)
		select @HouseSUID, LkHouseSource, Total, getdate()
		from HouseSource (nolock)
		where RowIsActive = 1 and HouseSUID = @ImportFromHouseSUID

		insert into HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal, DateModified)
		select @HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal, getdate()
		from HouseUse (nolock)
		where RowIsActive = 1 and HouseSUID = @ImportFromHouseSUID
end