
create procedure dbo.AddHousingVHCBAffordUnits
(
	@HousingID		int,
	@LkAffordunits	int,
	@Numunits		int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1
		from ProjectHouseVHCBAfford(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
    )
	begin
		insert into ProjectHouseVHCBAfford(HousingID, LkAffordunits, Numunits, DateModified)
		values(@HousingID, @LkAffordunits, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseVHCBAfford(nolock)
		where HousingID = @HousingID 
			and LkAffordunits = @LkAffordunits
	end

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