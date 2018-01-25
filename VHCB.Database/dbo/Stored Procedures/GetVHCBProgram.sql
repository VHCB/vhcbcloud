
CREATE procedure GetVHCBProgram
as
Begin
	select typeid, description from LookupValues 
	where lookuptype = 34 and RowIsActive = 1
end