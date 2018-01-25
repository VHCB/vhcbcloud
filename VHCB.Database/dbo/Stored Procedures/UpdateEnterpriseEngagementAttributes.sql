
create procedure dbo.UpdateEnterpriseEngagementAttributes
(
	@EnterEngageAttrID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEngagementAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEngagementAttributes 
	where EnterEngageAttrID = @EnterEngageAttrID

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