 
create procedure GetProjectFederalList  
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectFederalList 6612, 1
--select * from ProjectFederal
--select * from projecthomedetail
	select ProjectFederalID, pf.LkFedProg, lv.description FedProgram, pf.NumUnits, pf.RowIsActive
	from ProjectFederal pf(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pf.LkFedProg
	where (@IsActiveOnly = 0 or pf.RowIsActive = @IsActiveOnly) 
		and ProjectID = @ProjectID
	order by pf.DateModified desc
end