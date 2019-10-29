CREATE procedure GetFinalizeTransactions
(
	@ProjectID int
)
as
begin
	begin transaction

	begin try

	select t.TransId, pcr.ProjectCheckReqID, Voucher# as VoucherNumber, t.TransAmt, pcr.CRDate, pcr.InitDate, pcr.Paiddate 
	from projectcheckreq pcr(nolock)
	join Trans t(nolock) on pcr.ProjectCheckReqID = t.ProjectCheckReqID
	where pcr.ProjectID = @ProjectID and pcr.Voided = 0 and  Voucher# is not null and t.LKTransaction = 236

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
end