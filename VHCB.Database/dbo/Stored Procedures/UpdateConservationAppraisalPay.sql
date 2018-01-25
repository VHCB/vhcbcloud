
create procedure dbo.UpdateConservationAppraisalPay
(
	@AppraisalPayID int, 
	@PayAmt			money, 
	@WhoPaid		int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update AppraisalPay set PayAmt = @PayAmt, WhoPaid = @WhoPaid,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from AppraisalPay
	where AppraisalPayID = @AppraisalPayID
	
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