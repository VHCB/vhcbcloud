create view [dbo].[LkTransType_v] as
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkTransType')
		and RowIsActive = 1