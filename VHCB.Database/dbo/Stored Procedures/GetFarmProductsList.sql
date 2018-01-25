
create procedure GetFarmProductsList
(
	@FarmId			int,
	@IsActiveOnly	bit
)  
as
--exec GetFarmProductsList 1, 1
begin
	select fp.FarmProductsID, fp.LkProductCrop, lv.Description as Product, fp.StartDate, fp.RowIsActive 
	from FarmProducts fp(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fp.LkProductCrop
	where fp.FarmId = @FarmId
	and (@IsActiveOnly = 0 or fp.RowIsActive = @IsActiveOnly)
		order by fp.DateModified desc
end