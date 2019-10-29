
Create view conservationSourcesUsesCount_v as
	select c.ProjectID, c.ConserveID, csu.ConserveSUID, csu.LKBudgetPeriod, cs.SourceCount, cu.UsesCount
	from Conserve c(nolock)
	join conserveSU csu(nolock) on c.ConserveID = csu.ConserveID
	left join (select ConserveSUID, count(*) SourceCount from conserveSources(nolock) where RowIsActive = 1 group by  ConserveSUID )as cs on csu.ConserveSUID = cs.ConserveSUID
	left join (select ConserveSUID, count(*) UsesCount from conserveUses(nolock) where RowIsActive = 1 group by  ConserveSUID )as cu on csu.ConserveSUID = cu.ConserveSUID
	--where c.ProjectID = 6622