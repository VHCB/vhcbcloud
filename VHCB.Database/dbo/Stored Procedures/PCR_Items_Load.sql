

Create procedure [dbo].[PCR_Items_Load]
as
begin
	select typeid, LookupType, Description 
	from LookupValues(nolock)
	where LookupType = (select RecordID from LkLookups where tablename = 'PCRItems')
		and RowIsActive = 1
end