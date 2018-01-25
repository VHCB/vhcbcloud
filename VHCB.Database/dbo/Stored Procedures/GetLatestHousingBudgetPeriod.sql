
create procedure GetLatestHousingBudgetPeriod
(
	@ProjectID		int,
	@LKBudgetPeriod	int output
)  
as
--exec GetLatestHousingBudgetPeriod 66251, null
begin
	select  @LKBudgetPeriod = isnull(hsu.LkBudgetPeriod, 0) --isnull(max(hsu.LkBudgetPeriod), 0)
	from Housing h(nolock)
	join HouseSU hsu(nolock) on h.HousingID  = hsu.HousingId 
	where h.ProjectID = @ProjectID and MostCurrent = 1
end