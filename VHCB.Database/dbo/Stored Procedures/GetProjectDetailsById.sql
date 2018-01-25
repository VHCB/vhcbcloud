Create procedure [dbo].[GetProjectDetailsById]
(
	@projId int	
)
as 
Begin
	select p.ProjectId, p.Proj_num, lv.Description, pn.LkProjectname, * from Project P JOIN ProjectName pn on pn.ProjectID = p.ProjectId
	join LookupValues lv on lv.TypeID = pn.LkProjectname
	where p.ProjectId = @projId
end