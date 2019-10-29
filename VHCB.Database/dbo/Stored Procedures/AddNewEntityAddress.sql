
create procedure dbo.AddNewEntityAddress
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
	@DefAddress bit,
	@latitude float,
	@longitude	float,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	declare @AddressId int;
	declare @ApplicantAddressID int;

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from Address a(nolock) 
		join ApplicantAddress aa(nolock) on a.AddressId = aa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and aa.ApplicantId = @ApplicantId
	)
	begin
		insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, latitude, longitude, RowIsActive, UserID)
		values(@AddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @latitude, @longitude, @IsActive, 123)

		set @AddressId = @@identity	

		insert into ApplicantAddress(AddressId, ApplicantId, DefAddress, RowIsActive, [DateModified])
		values(@AddressId, @ApplicantId, @DefAddress, @IsActive, getdate())

		set @ApplicantAddressID = @@identity

		if(@DefAddress = 1)
		begin
		 update ApplicantAddress set Defaddress = 0 where ApplicantId = @ApplicantId and ApplicantAddressID != @ApplicantAddressID
		end

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  a.RowIsActive 
		from Address a(nolock) 
		join ApplicantAddress aa(nolock) on a.AddressId = aa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and aa.ApplicantId = @ApplicantId
	end

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