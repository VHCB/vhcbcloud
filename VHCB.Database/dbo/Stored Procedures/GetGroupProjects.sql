


Create procedure [dbo].[GetGroupProjects]

as

select	
		p.ProjectId, 		
		p.Proj_num

from Project p 
		join ProjectName pn on p.ProjectId = pn.ProjectID
		join LkProjectName lpn on lpn.NameID = pn.LkProjectname
group by p.ProjectId, p.Proj_num