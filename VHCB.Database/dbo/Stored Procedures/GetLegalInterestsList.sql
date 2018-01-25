
create procedure GetLegalInterestsList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetLegalInterestsList 1, 1
begin
	select  ca.ConserveLegInterestID, ca.LKLegInterest, lv.Description as LegalInterest, ca.RowIsActive
	from ConserveLegInterest ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKLegInterest
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end