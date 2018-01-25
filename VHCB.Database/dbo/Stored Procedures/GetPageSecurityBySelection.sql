create procedure GetPageSecurityBySelection
(
	@recordId int
)
as
Begin
	select typeid, description from lookupvalues 
	where lookuptype = @recordid
End