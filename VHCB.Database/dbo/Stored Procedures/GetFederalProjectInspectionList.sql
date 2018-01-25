
create procedure GetFederalProjectInspectionList  
(
	@ProjectFederalID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetFederalProjectInspectionList 1, 1

	select i.FederalProjectInspectionID, i.InspectDate, i.NextInspect, i.InspectStaff, i.InspectLetter, 
		i.RespDate, i.Deficiency, i.InspectDeadline, i.RowIsActive, dbo.GetApplicantName(i.InspectStaff) 'InspectionPerformedBy'
	from FederalProjectInspection i(nolock)
	where i.ProjectFederalID = @ProjectFederalID  
		and (@IsActiveOnly = 0 or i.RowIsActive = @IsActiveOnly)
	order by i.DateModified desc
end