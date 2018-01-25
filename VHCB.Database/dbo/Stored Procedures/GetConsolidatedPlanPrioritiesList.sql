
create procedure GetConsolidatedPlanPrioritiesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConsolidatedPlanPrioritiesList 1, 1
begin
	select  pcp.ProjectConPlanPrioritiesID, pcp.LkConplanPriorities, lv.description as Priorities, pcp.RowIsActive
	from ProjectConPlanPriorities pcp(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pcp.LkConplanPriorities
	where pcp.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pcp.RowIsActive = @IsActiveOnly)
		order by pcp.DateModified desc
end