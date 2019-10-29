
create procedure GetEnterpriseServProviderDataById
(
	@EnterpriseMasterServiceProvID		int
)  
as 
--exec GetEnterpriseServProviderDataById 2790
begin
	select m.ProjectID, m.Year, c.PrePost, 
	c.BusPlans, convert(varchar(10), c.BusPlanProjCost) BusPlanProjCost, 
	c.CashFlows, convert(varchar(10), c.CashFlowProjCost) CashFlowProjCost, 
	c.Yr2Followup, convert(varchar(10), c.Yr2FollowUpProjCost) Yr2FollowUpProjCost, 
	c.AddEnrollees, convert(varchar(10), c.AddEnrolleeProjCost) AddEnrolleeProjCost, 
	c.WorkshopsEvents, convert(varchar(10), c.WorkShopEventProjCost) WorkShopEventProjCost, 
	c.SpecialProj, c.Notes 
	from EnterpriseMasterServiceProvider m(nolock)
	join EnterpriseServProviderData c(nolock) on m.EnterpriseMasterServiceProvID = c.EnterpriseMasterServiceProvID
	where m.EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID
end