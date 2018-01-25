
create procedure dbo.AddAct250Projects
(
	@Act250FarmID	int, 
	@ProjectID		int, 
	@LKTownConserve	int, 
	@AmtFunds		money, 
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
		from Act250Projects(nolock)
		where ProjectID = @ProjectID 
			and LKTownConserve = @LKTownConserve 
			and AmtFunds = @AmtFunds
	)
	begin

		insert into Act250Projects(Act250FarmID, ProjectID, LKTownConserve, AmtFunds)
		values(@Act250FarmID, @ProjectID, @LKTownConserve, @AmtFunds)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250Projects(nolock)
		where ProjectID = @ProjectID 
			and LKTownConserve = @LKTownConserve 
			and AmtFunds = @AmtFunds
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