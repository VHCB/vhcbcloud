CREATE procedure GetProjectNumbersWithNameAndProjectType
(
	@ProjectNum varchar(50)
)  
as
--exec GetProjectNumbersWithNameAndProjectType 2016
begin
	if(CHARINDEX('-', @ProjectNum) > 0)
	begin
		select top 25 v.proj_num, rtrim(ltrim(v.project_name)) as project_name, 
		convert(varchar(25), v.proj_num) +'|' + rtrim(ltrim(v.project_name)) as project_num_name,
		lv.description +'|' + rtrim(ltrim(v.project_name)) as program_projectname
		from project_v v
		join Project p(nolock) on p.ProjectId = v.project_id
		join lookupvalues lv(nolock) on lv.Typeid = p.LkProgram
		where  v.proj_num like @ProjectNum+ '%' and defname = 1
	end
	else
	begin
		select top 25 v.proj_num, rtrim(ltrim(v.project_name)) as project_name, 
		convert(varchar(25), v.proj_num) +'|' + rtrim(ltrim(v.project_name)) as project_num_name,
		lv.description +'|' + rtrim(ltrim(v.project_name)) as program_projectname
		from project_v v
		join Project p(nolock) on p.ProjectId = v.project_id
		join lookupvalues lv(nolock) on lv.Typeid = p.LkProgram
		where  replace(v.proj_num, '-', '') like @ProjectNum+ '%' and defname = 1
	end
end