
create procedure dbo.UpdateProjectInteragency
(
	@ProjectInteragencyID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ProjectInteragency set Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectInteragency 
	where ProjectInteragencyID = @ProjectInteragencyID

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