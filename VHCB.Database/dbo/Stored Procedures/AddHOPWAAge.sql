
create procedure dbo.AddHOPWAAge
(
	@HOPWAID		int,
	@GenderAgeID	int,
	@GANum			int,
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
		from HOPWAAge(nolock)
		where HOPWAID = @HOPWAID 
			and GenderAgeID = @GenderAgeID
    )
	begin
		insert into HOPWAAge(HOPWAID, GenderAgeID, GANum)
		values(@HOPWAID, @GenderAgeID, @GANum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAAge(nolock)
		where HOPWAID = @HOPWAID 
			and GenderAgeID = @GenderAgeID
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