
create procedure dbo.GetProjectAddressList
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as 
--exec GetProjectAddressList 6588, 0
Begin

	select a.LkAddressType, 
	case (rtrim(ltrim(lv.description))) when 'Physical Location'then 'Physical'
	else  (rtrim(ltrim(lv.description))) end as AddressType, 
	a.AddressId, a.Street#, a.Address1, a.Address2, a.latitude, a.longitude, a.Town, a.State, a.Zip, a.County, 
	case isnull(pa.PrimaryAdd, '') when '' then 'No' when 0 then 'No' else 'Yes' end PrimaryAdd, a.RowIsActive
	from ProjectAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	left join LookupValues lv(nolock) on lv.typeid = a.LkAddressType
	where pa.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
	order by pa.PrimaryAdd desc, pa.DateModified desc
end