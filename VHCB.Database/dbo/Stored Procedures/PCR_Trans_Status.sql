
create procedure PCR_Trans_Status
as
begin
	select typeid, Description 
	from [dbo].[Lkstatus_v] 
	where LookupType = 124
	order by typeid
end