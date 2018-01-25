
create procedure dbo.GetHOPWAExpById
(
	@HOPWAExpID		int
) as
--GetHOPWAExpById 1
begin transaction

	begin try

	select HOPWAExpID, HOPWAProgramID, convert(varchar(10), Amount) Amount, Rent, Mortgage, Utilities, PHPUse, 
		convert(varchar(10), Date, 101) Date, DisbursementRecord, RowIsActive, DateModified
	from HOPWAExp hp(nolock) 
	where HOPWAExpID = @HOPWAExpID

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