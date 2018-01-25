
create procedure dbo.AddHOPWAProgram
(
	@HOPWAID	int, 
	@Program	int, 
	@Fund		int, 
	@Yr1		bit, 
	@Yr2		bit, 
	@Yr3		bit, 
	@StartDate	date, 
	@EndDate	date, 
	@Notes			nvarchar(max),
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
		from HOPWAProgram(nolock)
		where HOPWAID = @HOPWAID 
			and Program = @Program
    )
	begin
		insert into HOPWAProgram(HOPWAID, Program, Fund, Yr1, Yr2, Yr3, StartDate, EndDate, Notes)
		values(@HOPWAID, @Program, @Fund, @Yr1, @Yr2, @Yr3, @StartDate, @EndDate, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAProgram(nolock)
		where HOPWAID = @HOPWAID 
			and Program = @Program
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