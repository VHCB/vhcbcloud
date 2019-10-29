
create procedure GetProjectLeadUnitById
(
	@LeadUnitID int
)  
as
--exec GetProjectLeadUnitById 6
begin

	select LeadUnitID, Unit, EBLStatus, HHCount, Rooms, HHIncome, PartyVerified, IncomeStatus, MatchFunds, convert(varchar(10), ClearDate, 101) as ClearDate, 
		CertDate, ReCertDate, StartDate, convert(varchar(10), RelocationAmt) RelocationAmt, plu.RowIsActive
	from ProjectLeadUnit plu(nolock)
	where plu.LeadUnitID = @LeadUnitID
end