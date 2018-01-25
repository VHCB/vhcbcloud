CREATE procedure dbo.GetProjectSurfaceWatersById
(
	@SurfaceWatersID	int
) as
begin transaction

	begin try
	
	select LKWaterShed, SubWaterShed, LKWaterBody, FrontageFeet, OtherWater, Riparian, RowIsActive 
	from ProjectSurfaceWaters 
	where SurfaceWatersID = @SurfaceWatersID

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