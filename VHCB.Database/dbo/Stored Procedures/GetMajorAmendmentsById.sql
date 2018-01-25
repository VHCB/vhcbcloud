
create procedure dbo.GetMajorAmendmentsById
(
	@ConserveMajAmendID	int
) as
begin transaction

	begin try
	
	select ConserveMajAmendID, ConserveID, LkConsMajAmend, ReqDate, LkDisp, DispDate, Comments, URL, RowIsActive, DateModified 
	from  ConserveMajorAmend
	where ConserveMajAmendID = @ConserveMajAmendID

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