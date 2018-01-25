
create procedure dbo.GetMinorAmendmentsById
(
	@ConserveMinAmendID	int
) as
begin transaction

	begin try
	
	select ConserveMinAmendID, ConserveID, LkConsMinAmend, ReqDate, LkDisp, DispDate, Comments, URL, RowIsActive, DateModified
	from ConserveMinorAmend
	where ConserveMinAmendID = @ConserveMinAmendID

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