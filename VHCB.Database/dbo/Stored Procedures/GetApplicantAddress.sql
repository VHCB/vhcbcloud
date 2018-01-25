
CREATE procedure GetApplicantAddress
(
	@Applicantid		int
)
--exec GetApplicantAddress 1248
as
begin
	select top 1 a.AddressId, LkAddressType, lv.Description AddressType, Street#, Address1, Address2, Town, State, Zip, County, Country
	from ApplicantAddress aa(nolock)
	join address a(nolock) on aa.addressid = a.addressid
	left join LookupValues lv(nolock) on lv.TypeID = a.LkAddressType
	where a.RowIsActive = 1 and aa.applicantid = @Applicantid
	order by LkAddressType
end