
create procedure GetProjectLeadMilestoneById  
(
	@LeadMilestoneID	int
)
as
begin
--exec GetProjectLeadMilestoneById 1
	select LeadMilestoneID, ProjectID, LKMilestone, LeadBldgID, LeadUnitID, MSDate, URL, RowIsActive
	from ProjectLeadMilestone(nolock)
	where LeadMilestoneID = @LeadMilestoneID
end