
create procedure GetProjectFederalIncomeRestList
(
	@ProjectFederalID		int,
	@IsActiveOnly	bit
)  
as
--exec GetProjectFederalIncomeRestList 1, 0
begin
	select  hs.ProjectFederalIncomeRestID, hs.LkAffordunits, lv.description as Home, hs.Numunits, hs.RowIsActive
	from ProjectFederalIncomeRest hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkAffordunits
	where hs.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end