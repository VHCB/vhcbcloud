
create procedure GetProjectNumbersWithName
(
	@ProjectNum varchar(50)
)  
as
--exec GetProjectNumbersWithName 2016
begin
	if(CHARINDEX('-', @ProjectNum) > 0)
	begin
		select top 25 proj_num, rtrim(ltrim(project_name)) as project_name, convert(varchar(25), proj_num) +'|' + rtrim(ltrim(project_name)) as project_num_name
		from project_v
		where  proj_num like @ProjectNum+ '%' and defname = 1
	end
	else
	begin
		select top 25 proj_num, rtrim(ltrim(project_name)) as project_name, convert(varchar(25), proj_num) +'|' + rtrim(ltrim(project_name)) as project_num_name
		from project_v
		where  replace(proj_num, '-', '') like @ProjectNum+ '%' and defname = 1
	end
end