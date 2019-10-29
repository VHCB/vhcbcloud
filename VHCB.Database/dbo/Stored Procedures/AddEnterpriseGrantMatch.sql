CREATE procedure dbo.AddEnterpriseGrantMatch
(
	@EnterImpGrantID		int,
	@MatchDescID			int,
	@GrantAmt				money,
	@isDuplicate			bit output,
	@isActive				bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseGrantMatch (nolock)
		where EnterImpGrantID = @EnterImpGrantID and MatchDescID = @MatchDescID
    )
	begin
		insert into EnterpriseGrantMatch(EnterImpGrantID, MatchDescID, GrantAmt)
		values(@EnterImpGrantID, @MatchDescID, @GrantAmt)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseGrantMatch (nolock)
		where EnterImpGrantID = @EnterImpGrantID and MatchDescID = @MatchDescID
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