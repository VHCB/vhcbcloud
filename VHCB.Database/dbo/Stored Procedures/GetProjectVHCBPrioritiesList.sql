
create procedure GetProjectVHCBPrioritiesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectVHCBPrioritiesList 1, 1
begin
	select  pvhcb.ProjectVHCBPrioritiesID, pvhcb.LkVHCBPriorities, lv.Description as Priorities, pvhcb.RowIsActive
	from ProjectVHCBPriorities pvhcb(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pvhcb.LkVHCBPriorities
	where pvhcb.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pvhcb.RowIsActive = @IsActiveOnly)
		order by pvhcb.DateModified desc
end