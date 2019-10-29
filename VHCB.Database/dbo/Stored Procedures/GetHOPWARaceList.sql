
create procedure dbo.GetHOPWARaceList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWARaceList 1, 1
begin transaction

	begin try

	select HOPWARaceID, Race, lv.Description as RaceName, HouseholdNum, hr.RowIsActive, hr.DateModified
	from HOPWARace hr(nolock) 
	join lookupvalues lv(nolock) on hr.Race = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or hr.RowIsActive = @IsActiveOnly)
		order by hr.DateModified desc

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