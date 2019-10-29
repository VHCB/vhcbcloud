
create procedure GetAltEnergyList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAltEnergyList 1, 1
begin
	select  ca.ConsserveAltEnergyID, ca.LkAltEnergy, lv.Description as AlternativeEnergy, ca.RowIsActive
	from ConserveAltEnergy ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkAltEnergy
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end