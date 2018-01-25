
create procedure dbo.UpdateEntityAddress
(
	@ApplicantId int,
	@AddressId int,
	@LkAddressType	int,
	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@IsActive bit,
	@DefAddress bit,
	@latitude float,
	@longitude	float
)
as
begin transaction

	begin try

	update Address
		set 
		LkAddressType = @LkAddressType,
		Street# = @StreetNo,
		Address1 = @Address1,
		Address2 = @Address2,
		Town = @Town,
		State = @State,
		Zip = @Zip,
		County = @County,
		latitude = @latitude,
		longitude = @longitude,
		RowIsActive = @IsActive,
		DateModified = getdate()
	from Address
	where AddressId= @AddressId

	if(@Defaddress = 1 and @IsActive = 1)
	begin
	 update ApplicantAddress set DefAddress = 0 where ApplicantId = @ApplicantId
	end
	
	update ApplicantAddress
	set DefAddress = @Defaddress
	from ApplicantAddress
	where ApplicantId = @ApplicantId and AddressId= @AddressId

	end try
		begin catch
			if @@trancount > 0
			rollback transaction;

			DECLARE @msg nvarchar(4000) = error_message()
		  RAISERROR (@msg, 16, 1)
			return 1  
		end catch

		if @@trancount > 0
			commit transaction;