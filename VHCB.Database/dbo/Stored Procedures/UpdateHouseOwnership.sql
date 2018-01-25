
create procedure dbo.UpdateHouseOwnership
(
	@HomeOwnershipID		int, 
	@AddressID		int, 
	@MH				bit,
	@Condo			bit, 
	@SFD			bit, 
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update HomeOwnership set  AddressID = @AddressID, MH = @MH, Condo = @Condo, SFD = @SFD,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from HomeOwnership
	where HomeOwnershipID = @HomeOwnershipID
	
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