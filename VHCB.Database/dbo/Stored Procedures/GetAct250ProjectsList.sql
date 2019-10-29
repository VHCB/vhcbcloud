
create procedure GetAct250ProjectsList  
(
	@Act250FarmID	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250ProjectsList 5, 1
	select proj.Act250ProjectID, proj.ProjectID, v.Project_name as ProjectName, proj.LKTownConserve, lv.Description as ConservationTown,
	proj.AmtFunds, proj.DateClosed, proj.RowIsActive, proj.DateModified
	from Act250Projects proj(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = proj.LKTownConserve
	left join project_v v(nolock) on v.project_id = proj.ProjectID and v.defname = 1
	where Act250FarmID = @Act250FarmID 
	and (@IsActiveOnly = 0 or proj.RowIsActive = @IsActiveOnly)
	order by 1 desc
end