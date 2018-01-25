
create procedure GetAffordabilityMechanismsList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAffordabilityMechanismsList 1, 1
begin
	select  ca.ConserveAffmechID, ca.LkConsAffMech, lv.Description as AffordabilityMechanism, ca.RowIsActive
	from ConserveAffMech ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkConsAffMech
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end