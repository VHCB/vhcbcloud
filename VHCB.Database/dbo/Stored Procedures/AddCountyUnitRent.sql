
create procedure dbo.AddCountyUnitRent
(
	@CountyRentID	int, 
	@UnitType		int, 
	@HighRent		money, 
	@LowRent		money,
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
		from CountyUnitRents(nolock)
		where  CountyRentID = @CountyRentID 
			and UnitType = @UnitType
	)
	begin

		insert into CountyUnitRents(CountyRentID, UnitType, HighRent, LowRent)
		values(@CountyRentID, @UnitType, @HighRent, @LowRent)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from CountyUnitRents(nolock)
		where  CountyRentID = @CountyRentID 
			and UnitType = @UnitType
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