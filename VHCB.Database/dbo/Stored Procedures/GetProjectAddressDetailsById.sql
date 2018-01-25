
create procedure [dbo].GetProjectAddressDetailsById
(
	@ProjectId int,
	@AddressId int
)
as 
--exec GetProjectAddressDetailsById 20, 20
Begin

	select a.AddressId, a.LkAddressType, isnull(a.Street#, '') as Street#, isnull(a.Address1, '') as Address1, isnull(a.Address2, '') as Address2, 
	isnull(a.latitude, '') as latitude, isnull(a.longitude, '') as longitude, isnull(a.Town, '') as Town, isnull(a.State, '') as State, isnull(a.Zip, null) as Zip, 
	isnull(a.County, '') as County, isnull(Village, '') as Village,
	a.RowIsActive, pa.PrimaryAdd
	from projectAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	where a.AddressId= @AddressId and pa.ProjectId = @ProjectId
end