
create procedure dbo.AddHouseSingleCount
(
	@HousingID		int,
	@LkUnitChar		int,
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
		from ProjectHouseConsReuseRehab(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
    )
	begin
		insert into ProjectHouseConsReuseRehab(HousingID, LkUnitChar, Numunits, DateModified)
		values(@HousingID, @LkUnitChar, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseConsReuseRehab(nolock)
		where HousingID = @HousingID 
			and LkUnitChar = @LkUnitChar
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