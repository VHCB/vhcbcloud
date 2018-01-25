
create procedure dbo.AddConservationAppraisalPay
(
	@AppraisalInfoID	int, 
	@PayAmt				money, 
	@WhoPaid			int
) as
begin transaction

	begin try

	insert into AppraisalPay(AppraisalInfoID, PayAmt, WhoPaid)
	values(@AppraisalInfoID, @PayAmt, @WhoPaid)

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