
create procedure GetConserveUsesList
(
	@ProjectID		int,
	@LKBudgetPeriod int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveUsesList 1,26083
begin
	select  cs.ConserveUsesID, c.ConserveID, 
	cs.LkConUseVHCB, cs.VHCBTotal, lv.description VHCBUseName, 
	cs.LkConUseOther, cs.OtherTotal, lv1.Description OtherUseName,
	cs.VHCBTotal + cs.OtherTotal 'Total',
	cs.RowIsActive
	from Conserve c(nolock)
	join ConserveSU csu(nolock) on c.ConserveID = csu.ConserveID 
	join ConserveUses cs(nolock) on csu.ConserveSUID = cs.ConserveSUID
	join LookupValues lv(nolock) on lv.TypeId = cs.LkConUseVHCB
	join LookupValues lv1(nolock) on lv1.TypeId = cs.LkConUseOther
	where c.ProjectID = @ProjectID 
		and csu.LKBudgetPeriod = @LKBudgetPeriod
		and (@IsActiveOnly = 0 or cs.RowIsActive = @IsActiveOnly)
		order by cs.DateModified desc
end