
create procedure GetProjectInteragencyList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as 
--exec GetProjectInteragencyList 1, 1
begin
	select  pin.ProjectInteragencyID, pin.LkInteragency, lv.description as Priorities, pin.RowIsActive   
	from ProjectInteragency pin(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = pin.LkInteragency
	where pin.ProjectID = @ProjectID
	and (@IsActiveOnly = 0 or pin.RowIsActive = @IsActiveOnly)
		order by pin.DateModified desc
end