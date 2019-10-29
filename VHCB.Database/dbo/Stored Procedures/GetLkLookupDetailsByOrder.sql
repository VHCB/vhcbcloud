
CREATE procedure [dbo].[GetLkLookupDetailsByOrder]
(
	 @recordId int,
	 @IsActiveOnly	bit,
	 @order int
 )
as
begin	
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lv.Ordering, lk.Tiered
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where lk.RecordID = @recordId and lv.Ordering >= @order
		and (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lv.Ordering asc, lv.TypeID asc
end