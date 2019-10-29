
create procedure GetProjectOtherOutcomesList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectOtherOutcomesList 1, 1
begin
	select  po.ProjectOtherOutcomesID, po.LkOtherOutcomes, lv.Description as Priorities,  po.Numunits, po.RowIsActive
	from ProjectOtherOutcomes po(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = po.LkOtherOutcomes
	where po.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or po.RowIsActive = @IsActiveOnly)
		order by po.DateModified desc
end