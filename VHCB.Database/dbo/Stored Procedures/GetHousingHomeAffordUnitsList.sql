
create procedure GetHousingHomeAffordUnitsList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingHomeAffordUnitsList 1, 0
begin
	select  hs.ProjectHomeAffordUnitsID, hs.LkAffordunits, lv.description as Home, hs.Numunits, hs.RowIsActive
	from ProjectHomeAffordUnits hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end