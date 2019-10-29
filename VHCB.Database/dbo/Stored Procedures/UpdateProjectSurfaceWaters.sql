CREATE procedure dbo.UpdateProjectSurfaceWaters
(
	@SurfaceWatersID	int,
	@SubWaterShed		nvarchar(75), 
	@LKWaterBody		int, 
	@FrontageFeet		int,
	@OtherWater			nvarchar(75), 
	@Riparian			int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update ProjectSurfaceWaters set  SubWaterShed = @SubWaterShed, LKWaterBody = @LKWaterBody, FrontageFeet = @FrontageFeet, OtherWater = @OtherWater,
		Riparian = @Riparian, RowIsActive = @RowIsActive, DateModified = getdate()
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