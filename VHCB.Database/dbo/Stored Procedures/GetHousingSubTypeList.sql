
create procedure GetHousingSubTypeList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSubTypeList 1, 0
begin
	select  hs.HousingTypeID, hs.LkHouseType, lv.description as HouseType, hs.Units, hs.RowIsActive
	from ProjectHouseSubType hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkHouseType
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end