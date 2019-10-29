
create procedure GetAddressDetails
(
	@StreetNo	nvarchar(24)
	--@Address1	nvarchar(120)	
)
as 
Begin

	select  distinct top 10 Street#, Address1, isnull(Address2, '') Address2,
	case when convert(decimal(10,7), isnull(latitude, '')) = 0 then '' else convert(varchar, convert(decimal(10,7), isnull(latitude, ''))) end latitude,
	case when convert(decimal(10,7), isnull(longitude, '')) = 0 then '' else convert(varchar, convert(decimal(10,7), isnull(longitude, ''))) end longitude, 
	isnull(Town, '' ) Town, State, Zip, isnull(County, '') County, isnull(Village, '') Village 
	from address(nolock)
	where Street# like @StreetNo +'%'
end