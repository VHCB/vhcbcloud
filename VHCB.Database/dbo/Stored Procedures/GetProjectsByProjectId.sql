CREATE procedure [dbo].[GetProjectsByProjectId]
(
	@projId int
)
as

select	
		lpn.NameID, 
		p.projectid, 
		lpn.Proj_name,
		pn.DefName, 
		p.Proj_num, 
		pn.LkProjectname 
from Project p 
		join ProjectName pn on p.ProjectId = pn.ProjectID
		join LkProjectName lpn on lpn.NameID = pn.LkProjectname
where p.ProjectId = @projId