
create procedure [dbo].UpdateProjectAddress
(
	@ProjectId int,
	@AddressId int,
	@LkAddressType	int,
	@StreetNo nvarchar(24),
	@Address1 nvarchar(120),
	@Address2 nvarchar(120),
	@Town nvarchar(100),
	@Village nvarchar(35),
	@State nchar(4),
	@Zip nchar(20),
	@County nvarchar(40),
	@latitude float,
	@longitude	float,
	@IsActive bit,
	@DefAddress bit	
)
as
begin transaction

	begin try

	update Address
		set Street# = @StreetNo,
		LkAddressType = @LkAddressType,
		Address1 = @Address1,
		Address2 = @Address2,
		Village = @Village,
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
	 update ProjectAddress set PrimaryAdd = 0 where ProjectId = @ProjectId
	end
	
	update ProjectAddress
	set PrimaryAdd = @Defaddress
	from ProjectAddress
	where ProjectId = @ProjectId and AddressId= @AddressId

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