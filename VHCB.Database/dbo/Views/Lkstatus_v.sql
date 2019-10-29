create view Lkstatus_v as
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'Lkstatus')
		and RowIsActive = 1