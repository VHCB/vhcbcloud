CREATE procedure GetEnterpriseImpGrantsById
(
	@ProjectID		int
)  
as 
--exec GetEnterpriseImpGrantsById 2790
begin
	select EnterImpGrantID, ProjectID, FYGrantRound, Milestone, ProjTitle, ProjDesc, convert(varchar(10), ProjCost) ProjCost, 
		convert(varchar(10), Request) Request, convert(varchar(10), AwardAmt) AwardAmt, AwardDesc, LeveragedFunds, Comments, OtherNames
	from EnterpriseImpGrants (nolock)
	where ProjectID = @ProjectID
	
end