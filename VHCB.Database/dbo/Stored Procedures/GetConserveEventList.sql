
create procedure GetConserveEventList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetConserveEventList 1, 1 
begin 
	select  c.ConserveID, a.ConserveEventID, a.LKEvent, lv.Description as EventName, 
		a.DispDate, a.RowIsActive
	from Conserve c(nolock)
	join ConserveEvent a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LKEvent
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end