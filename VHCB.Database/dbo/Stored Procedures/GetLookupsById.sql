
CREATE procedure [dbo].[GetLookupsById]
(
	@recordId int
)
as
begin
	select RecordID, Viewname, LKDescription, Standard, Ordered, Tiered, RowIsActive from lklookups
	where RecordID = @recordId	
end