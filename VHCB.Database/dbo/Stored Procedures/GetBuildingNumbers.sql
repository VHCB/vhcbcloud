
create procedure GetBuildingNumbers
(
	@ProjectID	int
)
as 
--exec GetBuildingNumbers 6625
Begin
	select Building, LeadBldgID from ProjectLeadBldg(nolock) where ProjectID = @ProjectID and RowIsActive = 1
	order by Building
end