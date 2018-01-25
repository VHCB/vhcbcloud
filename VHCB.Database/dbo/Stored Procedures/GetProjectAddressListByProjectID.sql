
create procedure [dbo].GetProjectAddressListByProjectID
(
	@ProjectId int
)
as 
--exec GetProjectAddressListByProjectID 6625
Begin

	select a.AddressId, isnull(a.Street#, '')  + ' '+ isnull(a.Address1, '') + ' '+ isnull(a.Address2, '')
	+ ' ' + isnull(Village, '') + ' ' + isnull(a.Town, '')  + ' ' + isnull(a.State, '') + ' ' + isnull(a.Zip, null)  as 'Address'
	from projectAddress pa(nolock) 
	join Address a(nolock) on a.Addressid = pa.AddressId
	where pa.ProjectId = @ProjectId
end