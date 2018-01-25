
create procedure dbo.AddAct250DevPay
(
	@Act250FarmID	int, 
	@AmtRec			money, 
	@DateRec		datetime,
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
		from Act250DevPay(nolock)
		where AmtRec = @AmtRec 
			and  DateRec = @DateRec
	)
	begin

		insert into Act250DevPay(Act250FarmID, AmtRec, DateRec)
		values(@Act250FarmID, @AmtRec, @DateRec)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250DevPay(nolock)
		where AmtRec = @AmtRec 
			and  DateRec = @DateRec
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