
create procedure dbo.AddEnterpriseBusPlanUse
(
	@EnterPriseEvalID	int,
	@LKBusPlanUsage		int,
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
		from EnterpriseBusPlanUse (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and LKBusPlanUsage = @LKBusPlanUsage
    )
	begin
		insert into EnterpriseBusPlanUse(EnterpriseEvalID, LKBusPlanUsage)
		values(@EnterPriseEvalID, @LKBusPlanUsage)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseBusPlanUse (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and LKBusPlanUsage = @LKBusPlanUsage
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