CREATE procedure GetLandUsePermitFinancialsList  
(
	--As per Dan per Dan detail.LandUsePermitId = act250Farm.Act250FarmId
	--@LandUsePermit	int -- act250Farm.Act250FarmId
	@Act250FarmId int
)
as
begin
--exec GetLandUsePermitFinancialsList '12345678'
	select Date, Amount, Type, Status
	from VW_Committed_LandUsePermit
	where LandUsePermitID = @Act250FarmId
	order by 1 desc
end