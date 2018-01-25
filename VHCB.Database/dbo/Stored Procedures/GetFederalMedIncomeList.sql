
create procedure GetFederalMedIncomeList  
(
	@ProjectFederalID	int,
	@IsActiveOnly	bit
)
as
begin 
--exec GetFederalMedIncomeList 1, 1
	select fm.FederalMedIncomeID, fm.MedIncome, lv.Description as MedIncomeName, fm.NumUnits, fm.RowIsActive
	from FederalMedIncome fm(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = fm.MedIncome
	where fm.ProjectFederalID = @ProjectFederalID 
		and (@IsActiveOnly = 0 or fm.RowIsActive = @IsActiveOnly)
	order by fm.DateModified desc
end