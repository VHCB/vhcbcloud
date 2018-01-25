CREATE procedure [dbo].[GetLookups]
as
begin
	select RecordID, Tablename from lklookups
	order by Tablename asc
end