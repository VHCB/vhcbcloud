
create procedure GetConserveDetailsById
(
	@ProjectID		int
)  
as
--exec GetConserveDetailsById 1
begin
	select  c.ConserveID, c.LkConsTrack, lv.Description as ConservationTrack, c.PrimStew, c.NumEase, c.TotalAcres, 
	c.Wooded, c.Prime, c.Statewide, c.Tillable, c.Pasture, c.Unmanaged, c.FarmResident, Naturalrec,
	c.UserID
	from Conserve c(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = c.LkConsTrack
	where c.ProjectID = @ProjectID 
end