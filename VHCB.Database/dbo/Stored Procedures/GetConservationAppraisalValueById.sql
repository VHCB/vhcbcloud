
create procedure GetConservationAppraisalValueById
(
	@ProjectID int
)  
as
--exec GetConservationAppraisalValueById 6588
begin

	declare @TotAcres int

	select @TotAcres = TotalAcres
	from Conserve(nolock)
	where ProjectID = @ProjectID

	select AppraisalID, ProjectID, @TotAcres as TotAcres, 
	 convert(varchar(10), Apbef) Apbef, 
	  convert(varchar(10), Apaft) Apaft, 
	   convert(varchar(10), Aplandopt) Aplandopt, 
	    convert(varchar(10), Exclusion) Exclusion, EaseValue, Valperacre, 
	RowIsActive, Comments, convert(varchar(10), FeeValue) FeeValue
	from AppraisalValue (nolock)
	where ProjectID = @ProjectID
end