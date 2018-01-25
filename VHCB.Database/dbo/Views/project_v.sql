
CREATE view [dbo].[project_v] as
	select p.ProjectId as project_id, p.proj_num , lpn.description as project_name, pn.defname
	from project p(nolock)
	join ProjectName pn(nolock) on p.ProjectId = pn.ProjectID
	join LookupValues lpn on lpn.TypeID = pn.LkProjectname