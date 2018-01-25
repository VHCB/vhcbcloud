create procedure GetAllLandUsePermitForDecommitment
 (
	@ProjectId	int,
	@FundId		int
 )
as
begin
	
	if(@FundId = 420)
	begin
		select distinct af.UsePermit, af.Act250FarmId
		from Act250Farm af 
		join vw_FinancialDetailSummary v on v.LandUsePermitID = af.Act250FarmId
		where af.RowIsActive = 1 and af.type = 145 and v.projectid = @ProjectId --6606
	end
	else if(@FundId = 415)
	begin
		select distinct af.UsePermit, af.Act250FarmId
		from Act250Farm af 
		join vw_FinancialDetailSummary v on v.LandUsePermitID = af.Act250FarmId
		where af.RowIsActive = 1 and af.type = 144 and v.projectid = @ProjectId
	end
end