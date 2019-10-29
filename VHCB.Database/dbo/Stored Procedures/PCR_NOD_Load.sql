
CREATE procedure PCR_NOD_Load
as
begin
	select typeid, LookupType, Description 
	from LookupValues(nolock)
	where LookupType = (select RecordID from LkLookups where tablename = 'LkNOD')
		and RowIsActive = 1
end