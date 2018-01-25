
create procedure GetCountyUnitRentsList  
(
	@CountyRentID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetCountyUnitRentsList 1, 1
	select cur.CountyUnitRentID, cur.UnitType, lv.Description UnitTypeName, cur.HighRent, cur.LowRent, cur.RowIsActive
	from CountyUnitRents cur(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = cur.UnitType
	where CountyRentID = @CountyRentID 
		and (@IsActiveOnly = 0 or cur.RowIsActive = @IsActiveOnly)
	order by cur.DateModified desc
end