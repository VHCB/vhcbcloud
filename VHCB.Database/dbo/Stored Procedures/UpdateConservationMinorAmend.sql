
create procedure dbo.UpdateConservationMinorAmend
(
	@ConserveMinAmendID	int,
	@ReqDate			datetime,
	@LkDisp				int,
	@DispDate			datetime,
	@URL				nvarchar(1500),		
	@Comments			nvarchar(max),	
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveMinorAmend set  ReqDate= @ReqDate, LkDisp = @LkDisp, DispDate = @DispDate, 
		RowIsActive = @RowIsActive, DateModified = getdate(), Comments = @Comments, URL = @URL
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