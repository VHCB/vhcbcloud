
create procedure GetEnterpriseEngagementAttributesList
(
	@EnterFundamentalID		int,
	@IsActiveOnly	bit
)  
as
--exec GetEnterpriseEngagementAttributesList 1, 1
begin
	select  ca.EnterEngageAttrID, ca.LKAttributeID, lv.Description as Attribute, ca.RowIsActive
	from EnterpriseEngagementAttributes ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKAttributeID
	where ca.EnterFundamentalID = @EnterFundamentalID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end