
create procedure GetEnterpriseGrantAttributesList
(
	@EnterImpGrantID		int,
	@IsActiveOnly	bit
)  
as
--exec GetEnterpriseGrantAttributesList 1, 1
begin
	select  ca.EnterImpAttributeID, ca.LKAttributeID, lv.Description as Attribute, ca.RowIsActive
	from EnterpriseGrantAttributes ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKAttributeID
	where ca.EnterImpGrantID = @EnterImpGrantID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end