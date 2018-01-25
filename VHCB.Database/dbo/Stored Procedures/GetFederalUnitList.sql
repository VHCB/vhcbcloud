
create procedure GetFederalUnitList  
(
	@ProjectFederalID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetFederalUnitList 1, 1
	select fu.FederalUnitID, fu.ProjectFederalID, fu.UnitType, lv.Description as UnitTypeName, fu.NumUnits, fu.RowIsActive
	from FederalUnit fu(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fu.UnitType
	where fu.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fu.RowIsActive = @IsActiveOnly)
	order by fu.DateModified desc
end