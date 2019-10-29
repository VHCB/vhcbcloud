CREATE procedure PCR_Program
(
	@projId int
)
as
begin
	select distinct typeid, LookupType, Description from LookupValues lv
	join project p on p.lkprogram = lv.typeid
	where LookupType = (select recordid from LkLookups where tablename = 'LkProgram')
		and lv.RowIsActive = 1 and p.projectid=@projId
	order by TypeID
end