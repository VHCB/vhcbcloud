
create procedure GetHousingSecServList
(
	@HousingID		int,
	@IsActiveOnly	bit
)  
as
--exec GetHousingSecServList 1, 0
begin
	select  hs.ProjectSecSuppServID, hs.LKSecSuppServ, lv.description as Service, hs.Numunits, hs.RowIsActive
	from ProjectHouseSecSuppServ hs(nolock)
	join LookupValues lv(nolock) on lv.TypeId = hs.LKSecSuppServ
	where hs.HousingID = @HousingID 
		and (@IsActiveOnly = 0 or hs.RowIsActive = @IsActiveOnly)
		order by hs.DateModified desc
end