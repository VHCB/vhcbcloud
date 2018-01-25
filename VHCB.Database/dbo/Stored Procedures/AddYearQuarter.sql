
create procedure dbo.AddYearQuarter(
	@Year		int,
	@Qtr	int,
	@isDuplicate	bit output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	--set @isActive = 1
	
	if not exists
    (
		select 1
		from ACYrQtr(nolock)
		where [Year] = @Year 
			and Qtr = @Qtr
    )
	begin
		insert into ACYrQtr([Year], Qtr)
		values(@Year, @Qtr)
		
		set @isDuplicate = 0
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