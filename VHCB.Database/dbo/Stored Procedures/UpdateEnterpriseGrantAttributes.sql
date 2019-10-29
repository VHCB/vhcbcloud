
create procedure dbo.UpdateEnterpriseGrantAttributes
(
	@EnterImpAttributeID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseGrantAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseGrantAttributes 
	where EnterImpAttributeID = @EnterImpAttributeID

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