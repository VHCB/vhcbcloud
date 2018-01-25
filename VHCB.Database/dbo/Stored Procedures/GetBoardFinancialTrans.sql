CREATE proc [dbo].[GetBoardFinancialTrans]
as
begin
  select typeid as TypeID, Description from TransAction_v where typeid <> 236 order by Description
end