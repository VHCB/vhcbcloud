
create procedure dbo.GetHOPWAAgeList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAAgeList 1, 1
begin transaction

	begin try

	select HOPWAAgeId, GenderAgeID, lv.description as 'AgeGenderName', GANum, ha.RowisActive, ha.DateModified
	from HOPWAAge ha(nolock) 
	join lookupvalues lv(nolock) on ha.GenderAgeID = lv.TypeID
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or ha.RowIsActive = @IsActiveOnly)
		order by ha.DateModified desc

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