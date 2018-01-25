
create procedure dbo.GetLoanDetailListByLoanId
(
	@LoanId			int,
	@IsActiveOnly	bit
) as
--GetLoanDetailListByLoanId 6583, 1
begin transaction

	begin try

	select ld.LoanDetailID, ld.LoanID, ld.LoanCat, lv.Description LoanCategory,  ld.NoteDate, ld.MaturityDate, lm.NoteAmt, ld.IntRate, ld.Compound, ld.Frequency, 
		ld.PaymentType, ld.WatchDate, ld.RowIsActive
	from LoanDetail ld(nolock)
	join LoanMaster lm(nolock) on lm.LoanID = ld.LoanID
	left join lookupvalues lv(nolock) on lv.Typeid = ld.LoanCat
	where ld.LoanId = @LoanId
	and (@IsActiveOnly = 0 or ld.RowIsActive = @IsActiveOnly)
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