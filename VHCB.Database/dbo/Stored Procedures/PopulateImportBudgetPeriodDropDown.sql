
create procedure PopulateImportBudgetPeriodDropDown
(
	@ProjectID		int,
	@LKBudgetPeriod int
)  
as
begin
	--exec PopulateImportBudgetPeriodDropDown 6622, 26084
	if exists
    (
		select 1 
		from conservationSourcesUsesCount_v v(nolock)
		where ProjectID = @ProjectID 
			and LKBudgetPeriod = @LKBudgetPeriod
			and (isnull(v.SourceCount, 0) >0 or isnull(v.UsesCount, 0) > 0) 
	)
	begin
		select lv.TypeID, lv.Description 
		from  LookupValues lv(nolock)
		where 1 != 1
	end
	else
	begin
		select lv.TypeID, lv.Description 
		from conservationSourcesUsesCount_v v(nolock)
		join LookupValues lv(nolock) on lv.TypeId = v.LKBudgetPeriod
		where ProjectID = @ProjectID 
			and LKBudgetPeriod != @LKBudgetPeriod
			and (isnull(v.SourceCount, 0) >0 or isnull(v.UsesCount, 0) > 0) 
		order by LKBudgetPeriod
	end
end