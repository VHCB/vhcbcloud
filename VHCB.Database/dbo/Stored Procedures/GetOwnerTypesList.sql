
create procedure GetOwnerTypesList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetBuffersList 1, 1
begin
	select  ca.ConserveOTypeID, ca.LKOType, lv.Description as OwnerType, ca.RowIsActive
	from ConserveOType ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKOType
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end