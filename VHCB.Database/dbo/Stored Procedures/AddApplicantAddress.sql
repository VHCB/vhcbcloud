
create procedure [dbo].AddApplicantAddress
(
	@ApplicantId int,

	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@AddressType int,
	@IsActive bit,
	@DefAddress bit	
)
as 
Begin
	declare @AddressId int;

	insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, RowIsActive, UserID)
	values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @IsActive, 123)

	set @AddressId = @@identity	

	if(@Defaddress = 1 and @IsActive = 1)
	begin
	 update ApplicantAddress set Defaddress = 0 where ApplicantId = @ApplicantId
	end

	insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
	values(@AddressId, @ApplicantId, @DefAddress, @IsActive, getdate())
end