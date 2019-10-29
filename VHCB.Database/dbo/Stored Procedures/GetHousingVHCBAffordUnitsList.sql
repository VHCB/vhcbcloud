
create procedure GetHousingVHCBAffordUnitsList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingVHCBAffordUnitsList 1, 0
begin
	select  hs.ProjectVHCBAffordUnitsID, hs.LkAffordunits, lv.description as VHCB, hs.Numunits, hs.RowIsActive
	from ProjectHouseVHCBAfford hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end