CREATE procedure PCR_Projects
as
begin
	select project_id, proj_num, project_name,  convert(varchar(25), project_id) +'|' + project_name as project_id_name
	from project_v 
	where DefName = 1
	order by proj_num
end