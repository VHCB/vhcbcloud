
CREATE procedure [dbo].GetLkLookupSubValues
(
	 @typeId int,
	 @IsActiveOnly	bit
 )
as
begin
		select lv.TypeID, lsv.subtypeid, lv.Description,lv.RowIsActive, lsv.SubDescription
		from LookupValues lv join LookupSubValues lsv on lv.TypeID = lsv.TypeID	
		where lsv.RowIsActive = @IsActiveOnly and lv.typeid = @typeid
		order by lsv.SubDescription asc, lv.Description asc
	
End