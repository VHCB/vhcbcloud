CREATE procedure dbo.UpdateEnterpriseGrantMatch
(
	@EnterpriseGrantMatchID int,
	@GrantAmt			decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction
--exec UpdateEnterpriseGrantMatch 10, 0, 1
	begin try
	
	update EnterpriseGrantMatch set 
		 RowIsActive = @RowIsActive, GrantAmt = @GrantAmt, DateModified = getdate()
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