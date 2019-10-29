
CREATE procedure [dbo].[GetLookupDetailsByName]
(
	@lookupname varchar(30)
)
as
Begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = @lookupname)
	and RowIsActive = 1 order by Description 
End