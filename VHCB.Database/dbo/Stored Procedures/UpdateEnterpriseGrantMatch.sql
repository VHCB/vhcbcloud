
create procedure dbo.UpdateEnterpriseGrantMatch
(
	@EnterpriseGrantMatchID int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseGrantMatch set 
		 RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseGrantMatch 
	where EnterpriseGrantMatchID = @EnterpriseGrantMatchID

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