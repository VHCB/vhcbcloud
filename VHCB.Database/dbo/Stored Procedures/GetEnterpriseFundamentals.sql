CREATE  procedure GetEnterpriseFundamentals
(
	@ProjectID		int
)  
as 
--exec GetEnterpriseFundamentals 2790
begin
	select  EnterFundamentalID, isnull(efd.FiscalYr, 0) FiscalYr, efd.ProjectID, PlanType,
		ServiceProvOrg, 
		LeadAdvisor, 
		ProjDesc, BusDesc, efd.RowIsActive, LkProgram, lv2.Description 'ProjectProgram'
	from EnterpriseFundamentals efd(nolock)
	join Project p(nolock) on efd.ProjectID = p.ProjectId
	left join LookupValues lv(nolock) on lv.TypeID = efd.PlanType
	--left join LookupValues lv1(nolock) on lv1.TypeID = efd.HearAbout
	left join LookupValues lv2(nolock) on lv2.TypeID = LkProgram
	where efd.ProjectID = @ProjectID
end