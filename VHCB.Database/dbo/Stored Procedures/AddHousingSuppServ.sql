
create procedure dbo.AddHousingSuppServ
(
	@HousingID		int,
	@LkSuppServ		int,
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
		from ProjectHouseSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
    )
	begin
		insert into ProjectHouseSuppServ(HousingID, LkSuppServ, Numunits, DateModified)
		values(@HousingID, @LkSuppServ, @Numunits, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from ProjectHouseSuppServ(nolock)
		where HousingID = @HousingID 
			and LkSuppServ = @LkSuppServ
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