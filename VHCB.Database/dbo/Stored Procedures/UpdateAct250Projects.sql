
create procedure dbo.UpdateAct250Projects
(
	@Act250ProjectID	int, 
	--@ProjectID		int, 
	--@LKTownConserve	int, 
	@AmtFunds		money, 
	--@DateClosed		datetime,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250Projects set AmtFunds = @AmtFunds, --DateClosed = @DateClosed,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from Act250Projects
	where Act250ProjectID = @Act250ProjectID

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