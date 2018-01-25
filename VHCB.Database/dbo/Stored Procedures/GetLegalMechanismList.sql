
create procedure GetLegalMechanismList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetLegalMechanismList 1, 1
begin
	select  ca.ConserveLegMechID, ca.LKLegMech, lv.Description as LegalMechanism, ca.RowIsActive
	from ConserveLegMech ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKLegMech
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end