
create procedure GetCountyRentsList  
(
	@IsActiveOnly	bit
)
as
begin
--exec GetCountyRentsList 1, 1
	select cr.CountyRentId, cr.FedProgID, lv.description FedProgram, cr.county, lv1.description CountyName, cr.StartDate, cr.EndDate, cr.RowIsActive
	from CountyRents cr(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = cr.FedProgID
	left join LookupValues lv1(nolock) on lv1.TypeID = cr.county
	where (@IsActiveOnly = 0 or cr.RowIsActive = @IsActiveOnly)
	order by cr.DateModified desc
end