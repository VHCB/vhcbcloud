
create procedure GetProjectNumbers
(
	@ProjectNum varchar(50)
)  
as
--exec GetProjectNameById 6588
begin
	if(CHARINDEX('-', @ProjectNum) > 0)
	begin
		select top 25 proj_num
		from project
		where  proj_num like @ProjectNum+ '%'
	end
	else
	begin
		select top 25 proj_num 
		from project
		where  replace(proj_num, '-', '') like @ProjectNum+ '%'
	end
end