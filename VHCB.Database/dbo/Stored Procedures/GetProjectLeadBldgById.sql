
create procedure GetProjectLeadBldgById
(
	@LeadBldgID int
)  
as
--exec GetProjectLeadBldgById 6588
begin

	select LeadBldgID, ProjectID, Building, AddressID, Age, Type, LHCUnits, FloodHazard, FloodIns, VerifiedBy, InsuredBy, 
		HistStatus, AppendA, RowIsActive
	from ProjectLeadBldg (nolock)
	where LeadBldgID = @LeadBldgID
end