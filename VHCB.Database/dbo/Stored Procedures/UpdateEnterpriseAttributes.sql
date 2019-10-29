
create procedure dbo.UpdateEnterpriseAttributes
(
	@EnterpriseAttributeID		int,
	@Date				DateTime,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseAttributes set Date = @Date, RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseAttributes 
	where EnterpriseAttributeID = @EnterpriseAttributeID

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