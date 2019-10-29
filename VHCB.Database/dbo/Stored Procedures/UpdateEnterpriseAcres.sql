
create procedure dbo.UpdateEnterpriseAcres
(
	@EnterpriseAcresId		int,
	@AcresInProduction		int,
	@AcresOwned				int,
	@AcresLeased			int
) as
begin transaction

	begin try
	
	update EnterpriseAcres set AcresInProduction = @AcresInProduction, AcresOwned = @AcresOwned, AcresLeased = @AcresLeased, DateModified = getdate()
	from EnterpriseAcres 
	where EnterpriseAcresId = @EnterpriseAcresId

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