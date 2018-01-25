
create procedure GetProjectAgeRestrictList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetProjectAgeRestrictList 1, 0
begin
	select  hs.ProjectAgeRestrictID, hs.LKAgeRestrict, lv.description as AgeRestriction, hs.Numunits, hs.RowIsActive
	from ProjectHouseAgeRestrict hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LKAgeRestrict
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end