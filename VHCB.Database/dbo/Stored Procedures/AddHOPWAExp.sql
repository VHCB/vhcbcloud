
create procedure dbo.AddHOPWAExp
(
	@HOPWAProgramID	int,
	@Amount			decimal(18, 2),
	@Rent			bit,
	@Mortgage		bit, 
	@Utilities		bit, 
	@PHPUse			int, 
	@Date			date, 
	@DisbursementRecord	int,
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
		from HOPWAExp(nolock)
		where HOPWAProgramID = @HOPWAProgramID 
			and 1 = 2
    )
	begin
		insert into HOPWAExp(HOPWAProgramID, Amount, Rent, Mortgage, Utilities, PHPUse, Date, DisbursementRecord)
		values(@HOPWAProgramID, @Amount, @Rent, @Mortgage, @Utilities, @PHPUse, @Date, @DisbursementRecord)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from HOPWAExp(nolock)
		where HOPWAProgramID = @HOPWAProgramID 
			and 1 = 2
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