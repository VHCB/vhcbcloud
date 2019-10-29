CREATE procedure GetLKStatus
as
Begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'lkstatus')
	and RowIsActive = 1
End