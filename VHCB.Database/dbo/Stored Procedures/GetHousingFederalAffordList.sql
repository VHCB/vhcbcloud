
create procedure GetHousingFederalAffordList
(
	@ProjectFederalID	int,
	@IsActiveOnly		bit
)  
as
--exec GetHousingFederalAffordList 1, 0
begin
	select  fa.FederalAffordID, fa.AffordType, lv.Description as AffordTypeName, fa.NumUnits, fa.RowIsActive
	from FederalAfford fa(nolock)
	join LookupValues lv(nolock) on lv.TypeId = fa.AffordType
	where fa.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fa.RowIsActive = @IsActiveOnly)
		order by fa.DateModified desc
end