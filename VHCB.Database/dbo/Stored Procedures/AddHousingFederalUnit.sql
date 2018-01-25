
create procedure dbo.AddHousingFederalUnit
(
	@ProjectFederalID	int, 
	@UnitType			int, 
	@NumUnits			int,
	@isDuplicate		bit output,
	@isActive			bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1

	if not exists
    (
		select 1 
		from FederalUnit(nolock)
		where UnitType = @UnitType
			and ProjectFederalID= @ProjectFederalID
	)
	begin

		insert into FederalUnit(ProjectFederalID, UnitType, NumUnits)
		values(@ProjectFederalID, @UnitType, @NumUnits)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from FederalUnit(nolock)
		where UnitType = @UnitType
			and ProjectFederalID= @ProjectFederalID
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