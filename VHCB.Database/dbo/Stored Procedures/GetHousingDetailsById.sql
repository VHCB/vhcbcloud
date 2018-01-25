
create procedure GetHousingDetailsById
(
	@ProjectID		int
)  
as
--exec GetHousingDetailsById 6588
begin
	select h.HousingID, h.LkHouseCat, lv.Description as HouseCat, h.Hsqft, h.TotalUnits, h.Previous, h.NewUnits,
		h.RowIsActive, h.SASH, h.ServSuppUnits, UnitsRemoved, Vermod
	from Housing h(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = h.LkHouseCat
	where h.ProjectID = @ProjectID  
end