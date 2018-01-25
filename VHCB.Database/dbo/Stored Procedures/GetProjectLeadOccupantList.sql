
create procedure GetProjectLeadOccupantList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadOccupantList 6625, 1
	select LeadOccupantID, plo.LeadBldgID, plb.Building, plo.LeadUnitID, plu.Unit, plo.Name, plo.LKAge, lv2.description as Age,
		plo.LKEthnicity, lv.description as Ethnicity, plo.LKRace, lv1.description as Race, plo.RowIsActive
	from ProjectLeadOccupant plo(nolock)
	join ProjectLeadBldg plb(nolock) on plb.LeadBldgID = plo.LeadBldgID
	join ProjectLeadUnit plu(nolock) on plu.LeadUnitID = plo.LeadUnitID
	left join LookupValues lv(nolock) on lv.TypeID = plo.LKEthnicity
	left join LookupValues lv1(nolock) on lv1.TypeID = plo.LKRace
	left join LookupValues lv2(nolock) on lv2.TypeID = plo.LKAge
	where plo.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plo.RowIsActive = @IsActiveOnly)
	order by plo.DateModified desc
end