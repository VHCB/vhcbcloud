CREATE procedure dbo.GetProjectHomeOwnershipById
(
	@ProjectHomeOwnershipID	int
) as
begin transaction

	begin try

	select ProjectHomeOwnershipID, HomeOwnershipID, Owner, LkLender, vhfa, RDLoan, VHCBGrant, OwnerApprec, CapImprove, 
		InitFee, ResaleFee, StewFee, AssistLoan, RehabLoan, RowIsActive, DateModified, PurchaseDate
	from ProjectHomeOwnership(nolock)
	where ProjectHomeOwnershipID = @ProjectHomeOwnershipID
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