create view [dbo].[TransAction_v] as
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkTransAction')
		and RowIsActive = 1