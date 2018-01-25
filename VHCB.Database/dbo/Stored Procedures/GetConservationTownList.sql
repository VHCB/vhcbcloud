
create procedure GetConservationTownList
(
	@ProjectId Int
)
as
begin
--exec GetConservationTownList 6050
	select distinct town,  lv.TypeID
	from projectaddress pa(nolock)
	join address a(nolock) on pa.Addressid = a.addressid
	join LookupValues lv(nolock) on lv.Description = a.town
	where pa.projectid = @ProjectId and isnull(a.town, '') <> ''
	order by town
end