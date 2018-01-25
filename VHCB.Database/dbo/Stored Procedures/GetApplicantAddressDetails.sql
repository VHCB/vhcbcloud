
create procedure [dbo].[GetApplicantAddressDetails]
(
	@appnameid int	
)
as 
--exec GetApplicantAddressDetails 1034
Begin

	select a.AddressId, a.LkAddressType, a.Street#, a.Address1, a.Address2, a.latitude, a.longitude, a.Town, a.State, a.Zip, a.County, ad.Defaddress
	from ApplicantAddress ad(nolock) 
	join applicantappname aan(nolock) on ad.ApplicantId = aan.ApplicantId
	join Address a(nolock) on a.Addressid = ad.AddressId
	where a.RowIsActive = 1 and  aan.appnameid = @appnameid
	order by ad.Defaddress desc, ad.DateModified desc
end