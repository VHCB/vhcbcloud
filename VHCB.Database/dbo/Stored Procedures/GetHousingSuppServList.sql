
create procedure GetHousingSuppServList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSuppServList 1, 0
begin
	select  hs.ProjectSuppServID, hs.LkSuppServ, lv.description as Service, hs.Numunits, hs.RowIsActive
	from ProjectHouseSuppServ hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LkSuppServ
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end