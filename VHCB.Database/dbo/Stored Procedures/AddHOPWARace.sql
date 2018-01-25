
create procedure dbo.AddHOPWARace
(
	@HOPWAID		int,
	@Race			int,
	@HouseholdNum	int,
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
		from HOPWARace(nolock)
		where HOPWAID = @HOPWAID 
			and Race = @Race
    )
	begin
		insert into HOPWARace(HOPWAID, Race, HouseholdNum)
		values(@HOPWAID, @Race, @HouseholdNum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWARace(nolock)
		where HOPWAID = @HOPWAID 
			and Race = @Race
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