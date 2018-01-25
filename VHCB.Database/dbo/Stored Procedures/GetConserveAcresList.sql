
create procedure GetConserveAcresList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveAcresList 1, 1
begin
	select  c.ConserveID, a.ConserveAcresID, a.LkAcres, lv.Description as Description, a.Acres, a.RowIsActive
	from Conserve c(nolock)
	join ConserveAcres a(nolock) on c.ConserveID = a.ConserveID
	left join LookupValues lv(nolock) on lv.TypeID = a.LkAcres
	where c.ProjectID = @ProjectID 
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
		order by a.DateModified desc
end