CREATE procedure dbo.UpdateProjectHomeOwnership
(
	@ProjectHomeOwnershipID int,
	@Owner			int, 
	@LkLender		int, 
	@vhfa			bit, 
	@RDLoan			bit, 
	@VHCBGrant		money, 
	@OwnerApprec	money, 
	@CapImprove		money, 
	@InitFee		money, 
	@ResaleFee		money, 
	@StewFee		money, 
	@AssistLoan		money, 
	@RehabLoan		money,
	@PurchaseDate	date,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update ProjectHomeOwnership set  Owner = @Owner, LkLender = @LkLender, vhfa = @vhfa, RDLoan = @RDLoan, 
		VHCBGrant = @VHCBGrant, OwnerApprec = @OwnerApprec, CapImprove = @CapImprove, InitFee = @InitFee, 
		ResaleFee = @ResaleFee, StewFee = @StewFee, AssistLoan = @AssistLoan, RehabLoan = @RehabLoan, 
		RowIsActive = @IsRowIsActive, DateModified = getdate(), PurchaseDate = @PurchaseDate
	from ProjectHomeOwnership
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