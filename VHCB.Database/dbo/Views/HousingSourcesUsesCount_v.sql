
Create view HousingSourcesUsesCount_v as
	select h.ProjectID, h.HousingID, hsu.HouseSUID, hsu.LkBudgetPeriod, hs.SourceCount, hu.UsesCount
	from Housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID = hsu.HousingId
	left join (select HouseSUID, count(*) SourceCount from HouseSource(nolock) where RowIsActive = 1 group by  HouseSUID )as hs on hsu.HouseSUID = hs.HouseSUID
	left join (select HouseSUID, count(*) UsesCount from HouseUse(nolock) where RowIsActive = 1 group by  HouseSUID )as hu on  hsu.HouseSUID = hu.HouseSUID