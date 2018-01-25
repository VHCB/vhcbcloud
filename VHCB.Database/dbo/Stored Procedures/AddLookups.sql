
CREATE procedure [dbo].[AddLookups]
(
	@recordId int,
	@description varchar(100)
)
as
begin
	insert into LookupValues (Description, LookupType)
	values (@description, @recordId)
end