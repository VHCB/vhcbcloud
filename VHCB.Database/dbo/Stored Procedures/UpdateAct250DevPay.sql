
create procedure dbo.UpdateAct250DevPay
(
	@Act250PayID	int, 
	@AmtRec			money, 
	@DateRec		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250DevPay set AmtRec = @AmtRec, DateRec = @DateRec,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from Act250DevPay
	where Act250PayID = @Act250PayID
	
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