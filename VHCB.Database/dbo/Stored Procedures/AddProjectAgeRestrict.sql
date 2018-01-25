
create procedure dbo.AddProjectAgeRestrict
(
	@HousingID		int,
	@LKAgeRestrict	int,
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
		from ProjectHouseAgeRestrict(nolock)
		where HousingID = @HousingID 
			and LKAgeRestrict = @LKAgeRestrict
    )
	begin
		insert into ProjectHouseAgeRestrict(HousingID, LKAgeRestrict, Numunits, DateModified)
		values(@HousingID, @LKAgeRestrict, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseAgeRestrict(nolock)
		where HousingID = @HousingID 
			and LKAgeRestrict = @LKAgeRestrict
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