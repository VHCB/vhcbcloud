
create procedure GetProjectLeadUnitList  
(
	@LeadBldgID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadUnitList 1, 1
	select LeadUnitID, plb.Building, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, convert(varchar(10), ClearDate, 101) as ClearDate, 
		CertDate, ReCertDate, plu.RowIsActive
	from ProjectLeadUnit plu(nolock)
	join ProjectLeadBldg plb(nolock) on plu.LeadBldgID = plb.LeadBldgID
	where plu.LeadBldgID = @LeadBldgID
		and (@IsActiveOnly = 0 or plu.RowIsActive = @IsActiveOnly)
	order by plu.DateModified desc
end