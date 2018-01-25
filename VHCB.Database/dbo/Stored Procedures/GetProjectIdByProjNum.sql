CREATE procedure GetProjectIdByProjNum
(
	@filter varchar(20)
)
as
Begin
	select p.projectid, ltrim(lpn.description) as projName, (select description from lookupvalues where  LookupType = 119 and typeid = p.lkprojecttype) as description
		from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname	

	 where p.proj_num = @filter
End