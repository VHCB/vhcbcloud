CREATE procedure InactivateFinancialTransByTransId
(
	@transId int
)
as
begin transaction

	begin try

	delete from detail where TransId = @transId
	delete from trans where TransId = @transId

	delete from detail where TransId in(select ToTransID from TransAssign(nolock) where TransID = @transId)
	delete from trans where TransId in(select ToTransID from TransAssign(nolock) where TransID = @transId)

	delete from TransAssign where TransId = @transId
	--update Trans set RowIsActive = 0 Where TransId = @transId; 
	--update detail set RowIsActive = 0 Where TransId = @transId; 

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