
create procedure GetBuffersList
(
	@ConserveID		int,
	@IsActiveOnly	bit
)  
as
--exec GetBuffersList 1, 1
begin
	select  ca.ConserveBufferID, ca.LkBuffer, lv.Description as BufferType, ca.RowIsActive
	from ConserveBuffer ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LkBuffer
	where ca.ConserveID = @ConserveID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end