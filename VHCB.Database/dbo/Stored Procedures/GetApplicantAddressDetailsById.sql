
create procedure [dbo].GetApplicantAddressDetailsById
(
	@AddressId int
)
as 
--exec GetApplicantAddressDetailsById 47
Begin

	select a.AddressId, isnull(a.LkAddressType, '') as LkAddressType, isnull(a.Street#, '') as Street#, isnull(a.Address1, '') as Address1, isnull(a.Address2, '') as Address2, 
	isnull(a.latitude, '') as latitude, isnull(a.longitude, '') as longitude, isnull(a.Town, '') as Town, isnull(a.State, '') as State, isnull(a.Zip, null) as Zip, isnull(a.County, '') as County, 
	a.RowIsActive, ad.Defaddress
	from ApplicantAddress ad(nolock) 
	--join applicantappname aan(nolock) on ad.ApplicantId = aan.ApplicantId
	join Address a(nolock) on a.Addressid = ad.AddressId
	where a.AddressId= @AddressId
end