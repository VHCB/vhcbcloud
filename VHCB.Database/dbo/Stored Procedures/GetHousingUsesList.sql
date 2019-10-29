
create procedure GetHousingUsesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingUsesList 1,26083
begin
	select  hu.HouseUseID, h.HousingID, 
	hu.LkHouseUseVHCB, hu.VHCBTotal, lv.description VHCBUseName, 
	hu.LKHouseUseOther, hu.OtherTotal, '' OtherUseName,
	hu.VHCBTotal + hu.OtherTotal 'Total',
	hu.RowIsActive
	from housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	join HouseUse hu(nolock) on hsu.HouseSUID = hu.HouseSUID
	join LookupValues lv(nolock) on lv.TypeId = hu.LkHouseUseVHCB
	--join LookupValues lv1(nolock) on lv1.TypeId = hu.LKHouseUseOther
	where h.ProjectID = @ProjectID 
		and hsu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or hu.RowIsActive = @IsActiveOnly)
		order by hu.DateModified desc
end