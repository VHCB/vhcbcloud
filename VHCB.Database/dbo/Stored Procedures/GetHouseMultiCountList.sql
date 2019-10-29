
create procedure GetHouseMultiCountList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHouseMultiCountList 1, 0
begin
	select  hs.ProjectHouseAccessAdaptID, hs.LkUnitChar, lv.description as Characteristic, hs.Numunits, hs.RowIsActive
	from ProjectHouseAccessAdapt hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkUnitChar
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end