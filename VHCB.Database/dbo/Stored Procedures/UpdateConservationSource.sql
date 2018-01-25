
create procedure dbo.UpdateConservationSource
(
	@ConserveSourcesID	int,
	--@LkConSource		int,
	@Total				decimal(18, 2),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ConserveSources set --LkConSource = @LkConSource, 
		Total = @Total, RowIsActive = @RowIsActive, DateModified = getdate()
	from ConserveSources where ConserveSourcesID = @ConserveSourcesID

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