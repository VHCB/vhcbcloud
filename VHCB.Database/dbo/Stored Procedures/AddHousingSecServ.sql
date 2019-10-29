
create procedure dbo.AddHousingSecServ
(
	@HousingID		int,
	@LKSecSuppServ	int,
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
		from ProjectHouseSecSuppServ(nolock)
		where HousingID = @HousingID 
			and LKSecSuppServ = @LKSecSuppServ
    )
	begin
		insert into ProjectHouseSecSuppServ(HousingID, LKSecSuppServ, Numunits, DateModified)
		values(@HousingID, @LKSecSuppServ, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSecSuppServ(nolock)
		where HousingID = @HousingID 
			and LKSecSuppServ = @LKSecSuppServ
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