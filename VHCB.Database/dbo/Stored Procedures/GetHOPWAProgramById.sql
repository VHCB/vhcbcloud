
create procedure dbo.GetHOPWAProgramById
(
	@HOPWAProgramID		int
) as
--GetHOPWAProgramById 1, 1
begin transaction

	begin try

	select Program, Fund, Yr1, Yr2, Yr3, convert(varchar(10), StartDate, 101) StartDate, convert(varchar(10), EndDate, 101) EndDate, LivingSituationId, Notes, RowIsactive, DateModified
	from HOPWAProgram hp(nolock) 
	where HOPWAProgramID = @HOPWAProgramID

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