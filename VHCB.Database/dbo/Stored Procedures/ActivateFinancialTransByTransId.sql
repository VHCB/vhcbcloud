

CREATE procedure ActivateFinancialTransByTransId
(
	@transId int
)
as
begin transaction

	begin try

	update Trans set RowIsActive=1 Where TransId = @transId; 
	update detail set RowIsActive=1 Where TransId = @transId; 

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