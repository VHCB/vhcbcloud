
CREATE procedure AddLookupSubValues
(
	@typeId int,
	@subDescription varchar (100)
)
as
Begin
	insert into LookupSubValues(typeid,SubDescription)
	values (@typeId, @subDescription)
End