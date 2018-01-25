CREATE procedure dbo.AddProjectSurfaceWaters
(
	@ProjectId		int,
	@LKWaterShed	int,
	@SubWaterShed	nvarchar(75), 
	@LKWaterBody	int, 
	@FrontageFeet	int,
	@OtherWater		nvarchar(75), 
	@Riparian		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	--if not exists
 --   (
	--	select 1
	--	from ProjectSurfaceWaters(nolock)
	--	where ProjectID = @ProjectId 
	--		and LKWaterShed = @LKWaterShed
 --   )
	--begin
		insert into ProjectSurfaceWaters(ProjectID, LKWaterShed, SubWaterShed, LKWaterBody, FrontageFeet, OtherWater, Riparian, DateModified)
		values(@ProjectId, @LKWaterShed, @SubWaterShed, @LKWaterBody, @FrontageFeet, @OtherWater, @Riparian, getdate())
		
		set @isDuplicate = 0

	--end

	--if(@isDuplicate = 1)
	--begin
	--	select @isActive =  RowIsActive
	--	from ProjectSurfaceWaters(nolock)
	--	where ProjectID = @ProjectId 
	--		and LKWaterShed = @LKWaterShed 
	--end

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