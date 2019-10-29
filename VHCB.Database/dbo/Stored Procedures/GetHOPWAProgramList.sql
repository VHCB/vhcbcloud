
create procedure dbo.GetHOPWAProgramList
(
	@HOPWAId		int,
	@IsActiveOnly	bit
) as
--GetHOPWAProgramList 1, 1
begin transaction

	begin try

	select HOPWAProgramID, Program, lv.description ProgramName, Fund,f.name as 'FundName', Yr1, Yr2, Yr3, 
		convert(varchar(10), StartDate, 101) StartDate, convert(varchar(10), EndDate, 101) EndDate, LivingSituationId, Notes, hp.RowIsactive, hp.DateModified
	from HOPWAProgram hp(nolock) 
	join lookupvalues lv(nolock) on hp.Program = lv.TypeID
	join Fund f(nolock) on f.fundid = hp.fund
	where HOPWAId = @HOPWAId 
		and (@IsActiveOnly = 0 or hp.RowIsActive = @IsActiveOnly)
		order by hp.DateModified desc

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