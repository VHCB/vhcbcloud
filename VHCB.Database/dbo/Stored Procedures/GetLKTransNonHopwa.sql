
CREATE procedure [dbo].GetLKTransNonHopwa
as
Begin
	select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'LkTransType')
	and RowIsActive = 1 and [description]  in ('Contract','Loan', 'Grant')
	order by Description 
End