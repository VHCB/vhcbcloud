CREATE procedure GetProjectNameById
(
	@ProjectId int
)  
as
--exec GetProjectNameById 6588
begin

	select rtrim(ltrim(lpn.description)) as ProjectName, p.proj_num as ProjNumber, p.LkProjectType
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	where p.ProjectId = @ProjectId and pn.DefName = 1
end