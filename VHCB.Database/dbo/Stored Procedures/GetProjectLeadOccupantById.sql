
create procedure GetProjectLeadOccupantById  
(
	@LeadOccupantID		int
)
as
begin
--exec GetProjectLeadOccupantById 1
	select plo.LeadOccupantID, plo.LeadBldgID, plo.LeadUnitID, plo.Name, plo.LKAge,
		plo.LKEthnicity, plo.LKRace, plo.RowIsActive
	from ProjectLeadOccupant plo(nolock)
	where LeadOccupantID = @LeadOccupantID
end