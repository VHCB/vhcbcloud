
create procedure dbo.AddHousingSubType
(
	@HousingID		int,
	@LkHouseType	int,
	@Units			int,
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
		from ProjectHouseSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
    )
	begin
		insert into ProjectHouseSubType(HousingID, LkHouseType, Units, DateModified)
		values(@HousingID, @LkHouseType, @Units, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSubType(nolock)
		where HousingID = @HousingID 
			and LkHouseType = @LkHouseType
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