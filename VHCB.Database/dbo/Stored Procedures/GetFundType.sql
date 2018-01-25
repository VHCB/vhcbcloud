CREATE procedure [dbo].[GetFundType]
as
begin
	select typeid, Description, RowIsActive from LookupValues where lookuptype = 40
	order by Description
end