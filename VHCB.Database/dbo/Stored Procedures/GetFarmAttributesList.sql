
create procedure GetFarmAttributesList
(
	@FarmId			int,
	@IsActiveOnly	bit
)  
as
--exec GetFarmAttribList 1, 1
begin
	select  fa.FarmAttributeID, fa.LKFarmAttributeID, lv.Description as Attribute, fa.RowIsActive
	from FarmAttributes fa(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fa.LKFarmAttributeID
	where fa.FarmId = @FarmId
	and (@IsActiveOnly = 0 or fa.RowIsActive = @IsActiveOnly)
		order by fa.DateModified desc
end