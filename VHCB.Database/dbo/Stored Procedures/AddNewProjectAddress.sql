
create procedure dbo.AddNewProjectAddress
(
	@ProjectId	int,
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
	--@IsActive bit,
	@DefAddress bit,
	@LkAddressType	int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	declare @AddressId int;
	declare @ProjectAddressId int;

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from Address a(nolock) 
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and pa.ProjectId = @ProjectId
	)
	begin
		insert into [Address] (LkAddressType, Street#, Address1, Address2, Town, State, Zip, County, latitude, longitude, Village, UserID)
		values(@LkAddressType, @StreetNo, @Address1, @Address2, @Town, @State, @Zip, @County, @latitude, @longitude, @Village, 123)

		set @AddressId = @@identity	

		insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd, DateModified)
		values(@ProjectId, @AddressId, @DefAddress, getdate())

		set @ProjectAddressId = @@identity

		if(@DefAddress = 1)
		begin
		 update ProjectAddress set PrimaryAdd = 0 where ProjectId = @ProjectId and ProjectAddressID != @ProjectAddressId
		end

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  a.RowIsActive 
		from Address a(nolock) 
		join ProjectAddress pa(nolock) on a.AddressId = pa.AddressId
		where a.Street# = @StreetNo and a.Address1 = @Address1 and Town = @Town and pa.ProjectId = @ProjectId
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