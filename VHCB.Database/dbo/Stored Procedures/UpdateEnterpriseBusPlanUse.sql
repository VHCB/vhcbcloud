
create procedure dbo.UpdateEnterpriseBusPlanUse
(
	@EnterBusPlanUseID int,
	--LKBusPlanUsage
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseBusPlanUse set RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseBusPlanUse 
	where EnterBusPlanUseID = @EnterBusPlanUseID

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