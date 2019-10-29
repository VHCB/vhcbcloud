
create procedure dbo.GetConserveViolationsById
(
	@ConserveViolationsID	int
) as
begin transaction
-- GetConserveViolationsById 2
	begin try
	
	select ConserveViolationsID, ConserveID, LkConsViol, ReqDate, LkDisp, DispDate, Comments, URL, RowIsActive, DateModified
	from ConserveViolations
	where ConserveViolationsID = @ConserveViolationsID

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