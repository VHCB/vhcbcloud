
create procedure dbo.GetEntityAddressDetailsList
(
	@ApplicantId	int,
	@IsActiveOnly	bit
)
as 
--exec GetEntityAddressDetailsList 1034, 1
Begin

	select a.AddressId, a.LkAddressType, 
	case (rtrim(ltrim(lv.description))) when 'Physical Location'then 'Physical'
	else  (rtrim(ltrim(lv.description))) end as AddressType, 
	a.Street#, a.Address1, a.Address2, a.latitude, a.longitude, a.Town, a.State, a.Zip, a.County, ad.Defaddress, a.RowIsActive
	from ApplicantAddress ad(nolock) 
	join Address a(nolock) on a.Addressid = ad.AddressId
	left join LookupValues lv(nolock) on lv.typeid = a.LkAddressType
	where ad.ApplicantId = @ApplicantId
	and (@IsActiveOnly = 0 or a.RowIsActive = @IsActiveOnly)
	order by ad.DefAddress desc, ad.DateModified desc
end