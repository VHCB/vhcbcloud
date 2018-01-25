
create procedure dbo.AddHOPWAEthnicity
(
	@HOPWAID		int,
	@Ethnic			int,
	@EthnicNum		int,
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
		from HOPWAEthnic(nolock)
		where HOPWAID = @HOPWAID 
			and Ethnic = @Ethnic
    )
	begin
		insert into HOPWAEthnic(HOPWAID, Ethnic, EthnicNum)
		values(@HOPWAID, @Ethnic, @EthnicNum)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAEthnic(nolock)
		where HOPWAID = @HOPWAID 
			and Ethnic = @Ethnic
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