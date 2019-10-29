
create procedure GetConserveAttribList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetConserveAttribList 1, 1
begin
	select  ca.ConserveAttribID, ca.LkConsAttrib, lv.Description as Attribute, ca.RowIsActive
	from ConserveAttrib ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkConsAttrib
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end