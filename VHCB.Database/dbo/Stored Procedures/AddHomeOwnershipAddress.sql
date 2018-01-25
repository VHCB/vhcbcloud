
create procedure dbo.AddHomeOwnershipAddress
(
	@ProjectID		int, 
	@AddressID		int, 
	@MH				bit, 
	@Condo			bit, 
	@SFD			bit, 
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from HomeOwnership ho(nolock)
		where ho.ProjectId = @ProjectID and AddressID = @AddressID
	)
	begin

		insert into HomeOwnership(ProjectId, AddressID, MH, Condo, SFD)
		values(@ProjectId, @AddressID, @MH, @Condo, @SFD)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  ho.RowIsActive 
		from HomeOwnership ho(nolock)
		where ho.ProjectId = @ProjectID and AddressID = @AddressID
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