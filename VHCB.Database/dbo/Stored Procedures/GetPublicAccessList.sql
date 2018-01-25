
create procedure GetPublicAccessList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetAffordabilityMechanismsList 1, 1
begin
	select  ca.ConservePAcessID, ca.LkPAccess, lv.Description as PublicAccess, ca.RowIsActive
	from ConservePAccess ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkPAccess
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end