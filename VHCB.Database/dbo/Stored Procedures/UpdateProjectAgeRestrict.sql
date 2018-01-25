
create procedure dbo.UpdateProjectAgeRestrict
(
	@ProjectAgeRestrictID	int,
	@Numunits				int,
	@RowIsActive			bit
) as
begin transaction

	begin try

	update ProjectHouseAgeRestrict set  Numunits = @Numunits, RowIsActive = @RowIsActive, DateModified = getdate()
	from ProjectHouseAgeRestrict
	where ProjectAgeRestrictID = @ProjectAgeRestrictID

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