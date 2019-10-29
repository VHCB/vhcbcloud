
CREATE procedure [dbo].[GetLookupsViewname]
(
 @flagActive bit
)
as
begin
	select RecordID, Viewname from lklookups
	where Standard = 1 and RowIsActive = @flagActive
	order by Viewname asc
end