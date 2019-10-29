
create procedure GetConserveSourcesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveSourcesList 6622,26084, 0
begin
	select  cs.ConserveSourcesID, c.ConserveID, cs.LkConSource, cs.Total, lv.description SourceName, cs.RowIsActive
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveSources cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConSource
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or cs.RowIsActive = @IsActiveOnly)
		order by cs.DateModified desc
end