
create procedure dbo.UpdateConservationUse
(
	@ConserveUsesID	int,
	@VHCBTotal			decimal(18, 2),
	@OtherTotal			decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveUses set --LkConSource = @LkConSource, 
		VHCBTotal = @VHCBTotal, OtherTotal = @OtherTotal, RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveUses where ConserveUsesID = @ConserveUsesID

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