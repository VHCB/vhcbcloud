CREATE procedure [dbo].[GetLkLookupDetails]
(
	 @recordId int,
	 @IsActiveOnly	bit
 )
as
begin
	if (@recordId = 0)
	begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lv.Ordering, lk.Tiered, isnull(lv.SubReq, 0)  as subreq
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lv.Ordering desc, lk.Viewname asc
	end
	else
	Begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lv.Ordering, lk.Tiered, isnull(lv.Subreq, 0) as subreq		
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where lk.RecordID = @recordId 
		and (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lv.Ordering desc, lk.Viewname asc
	end
end