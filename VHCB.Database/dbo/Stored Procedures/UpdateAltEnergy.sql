
create procedure dbo.UpdateAltEnergy
(
	@ConsserveAltEnergyID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveAltEnergy set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveAltEnergy 
	where ConsserveAltEnergyID = @ConsserveAltEnergyID

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