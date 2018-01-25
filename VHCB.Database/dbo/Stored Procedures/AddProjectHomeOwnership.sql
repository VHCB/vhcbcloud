
create procedure dbo.AddProjectHomeOwnership
( 
	@HomeOwnershipID	int, 
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
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from ProjectHomeOwnership pho(nolock)
		where pho.Owner = @Owner and LkLender = @LkLender
	)
	begin

		insert into ProjectHomeOwnership(HomeOwnershipID, Owner, LkLender, vhfa, RDLoan, VHCBGrant, OwnerApprec, CapImprove, 
			InitFee, ResaleFee, StewFee, AssistLoan, RehabLoan, PurchaseDate)
		values(@HomeOwnershipID, @Owner, @LkLender, @vhfa, @RDLoan, @VHCBGrant, @OwnerApprec, @CapImprove, 
			@InitFee, @ResaleFee, @StewFee, @AssistLoan, @RehabLoan, @PurchaseDate)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  pho.RowIsActive 
		from ProjectHomeOwnership pho(nolock)
		where pho.Owner = @Owner and LkLender = @LkLender
	end

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