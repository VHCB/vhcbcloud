

CREATE procedure [dbo].GetLKTransHopwa

as
Begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkTransType')
	and RowIsActive = 1 and [description] not in ('Contract','Loan', 'Grant')
	order by Description 
End