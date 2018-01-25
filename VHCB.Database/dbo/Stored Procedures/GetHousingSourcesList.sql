
create procedure GetHousingSourcesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSourcesList 6622,26084, 0
begin
	select  hs.HouseSourceID, h.HousingID, hs.LkHouseSource, hs.Total, lv.description SourceName, hs.RowIsActive
	from housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	join houseSource hs(nolock) on hsu.HouseSUID = hs.HouseSUID
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseSource
	where h.ProjectID = @ProjectID 
		and hsu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end