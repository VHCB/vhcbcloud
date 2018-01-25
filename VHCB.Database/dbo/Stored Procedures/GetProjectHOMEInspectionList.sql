
create procedure GetProjectHOMEInspectionList  
(
	@ProjectFederalDetailID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetProjectHOMEInspectionList 1, 1

	select i.ProjectHOMEInspectionID, i.InspectDate, i.NextInspect, i.InspectStaff, i.InspectLetter, 
		i.RespDate, i.Deficiency, i.InspectDeadline, i.RowIsActive, dbo.GetApplicantName(i.InspectStaff) 'InspectionPerformedBy'
	from ProjectHOMEInspection i(nolock)
	where i.ProjectFederalDetailID = @ProjectFederalDetailID 
		and (@IsActiveOnly = 0 or i.RowIsActive = @IsActiveOnly)
	order by i.DateModified desc
end