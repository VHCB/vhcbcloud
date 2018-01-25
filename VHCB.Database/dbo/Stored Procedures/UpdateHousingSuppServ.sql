
create procedure dbo.UpdateHousingSuppServ
(
	@ProjectSuppServID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseSuppServ set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseSuppServ
	where ProjectSuppServID = @ProjectSuppServID

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