CREATE procedure getprojectslist 
as
begin

	select p.projectid, proj_num, rtrim(ltrim(lpn.description)) description,  convert(varchar(25), p.projectid) +'|' + rtrim(ltrim(lpn.description)) as project_id_name,
		rtrim(ltrim(lpn.description))  +' ' + convert(varchar(25), p.proj_num)  as project_num_name
	from project p(nolock)
	join projectname pn(nolock) on p.projectid = pn.projectid
	join lookupvalues lpn on lpn.typeid = pn.lkprojectname
	where defname = 1
	order by proj_num
end