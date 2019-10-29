
create procedure dbo.UpdateHouseSingleCount
(
	@ProjectHouseConsReuseRehabID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseConsReuseRehab set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseConsReuseRehab
	where ProjectHouseConsReuseRehabID = @ProjectHouseConsReuseRehabID

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