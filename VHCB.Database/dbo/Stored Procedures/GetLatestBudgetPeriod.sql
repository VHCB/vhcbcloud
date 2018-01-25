
create procedure GetLatestBudgetPeriod
(
	@ProjectID		int,
	@LKBudgetPeriod	int output
)  
as
--exec GetLatestBudgetPeriod 66251, null
begin
	--select  @LKBudgetPeriod = isnull(max(csu.LKBudgetPeriod), 0)
	select  @LKBudgetPeriod = isnull(csu.LKBudgetPeriod, 0)
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	where c.ProjectID = @ProjectID  and csu.MostCurrent = 1
end