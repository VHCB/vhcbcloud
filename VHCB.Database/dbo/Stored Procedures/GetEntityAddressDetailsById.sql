
create procedure [dbo].GetEntityAddressDetailsById
(
	@ApplicantId	int,
	@AddressId		int
)
as 
--exec GetEntityAddressDetailsById 20, 20
Begin

	select a.LkAddressType,  a.AddressId, isnull(a.Street#, '') as Street#, isnull(a.Address1, '') as Address1, isnull(a.Address2, '') as Address2, 
	isnull(a.latitude, '') as latitude, isnull(a.longitude, '') as longitude, isnull(a.Town, '') as Town, isnull(a.State, '') as State, isnull(a.Zip, null) as Zip, 
	isnull(a.County, '') as County, isnull(Village, '') as Village,
	a.RowIsActive, pa.DefAddress
	from ApplicantAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	where a.AddressId= @AddressId and pa.ApplicantId = @ApplicantId
end