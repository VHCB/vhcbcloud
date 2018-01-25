
create procedure dbo.UpdateProjectOtherOutcomes
(
	@ProjectOtherOutcomesID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ProjectOtherOutcomes set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectOtherOutcomes 
	where ProjectOtherOutcomesID = @ProjectOtherOutcomesID

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