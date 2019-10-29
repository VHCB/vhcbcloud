CREATE procedure GetProjectLeadMilestoneList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadMilestoneList 6625, 1
	select LeadMilestoneID, LKMilestone, lv.Description as Milestone, plm.LeadBldgID, plb.Building, plm.LeadUnitID, plu.Unit, MSDate, 
	URL, CASE when isnull(URL, '') = '' then '' else 'Click here' end as URLText, plm.RowIsActive
	from ProjectLeadMilestone plm(nolock)
	join ProjectLeadBldg plb(nolock) on plb.LeadBldgID = plm.LeadBldgID
	left join ProjectLeadUnit plu(nolock) on plu.LeadUnitID = plm.LeadUnitID
	left join LookupValues lv(nolock) on lv.TypeID = plm.LKMilestone
	where plm.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plm.RowIsActive = @IsActiveOnly)
	order by plm.DateModified desc
end