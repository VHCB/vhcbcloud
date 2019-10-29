
create procedure [dbo].UpdateApplicantAddress
(
	@ApplicantId	int,
	@AddressId		int,
	@StreetNo		nvarchar(24),
	@Address1		nvarchar(120),
	@Address2		nvarchar(120),
	@Town			nvarchar(100),
	@State			nchar(4),
	@Zip			nchar(20),
	@County			nvarchar(40),
	@AddressType	int,
	@IsActive		bit,
	@DefAddress		bit	
)
as 
Begin

	update Address
		set LkAddressType = @AddressType,
		Street# = @StreetNo,
		Address1 = @Address1,
		Address2 = @Address2,
		Town = @Town,
		State = @State,
		Zip = @Zip,
		County = @County,
		RowIsActive = @IsActive
	from Address
	where AddressId= @AddressId

	if(@Defaddress = 1 and @IsActive = 1)
	begin
	 update ApplicantAddress set Defaddress = 0 where ApplicantId = @ApplicantId
	end
	
	--select * from ApplicantAddress

	update ApplicantAddress
	set Defaddress = @Defaddress
	from ApplicantAddress
	where AddressId= @AddressId
end