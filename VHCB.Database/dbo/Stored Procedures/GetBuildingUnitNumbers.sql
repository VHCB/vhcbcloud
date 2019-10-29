
create procedure GetBuildingUnitNumbers
(
	@LeadBldgID	int 
)
as 
--exec GetBuildingUnitNumbers 8
Begin
	select Unit, LeadUnitID from ProjectLeadUnit(nolock) where LeadBldgID = @LeadBldgID and RowIsActive = 1
	order by Unit
end