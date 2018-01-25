
create procedure dbo.GetHOPWAExpList
(
	@HOPWAProgramID		int,
	@IsActiveOnly		bit
) as
--GetHOPWAExpList 3, 1
begin transaction

	begin try
	declare @ProgramName nvarchar(250)

	select @ProgramName = lv.description
	from HOPWAProgram hp(nolock)
	join lookupvalues lv(nolock) on hp.Program = lv.TypeID
	where HOPWAProgramID = @HOPWAProgramID

	select HOPWAExpID, @ProgramName ProgramName, Amount, Rent, Mortgage, Utilities, PHPUse, lv.description PHPUseName, convert(varchar(10), Date, 101) Date, 
		DisbursementRecord, hp.RowIsActive
	from HOPWAExp hp(nolock) 
	left join lookupvalues lv(nolock) on hp.PHPUse = lv.TypeID
	where HOPWAProgramID = @HOPWAProgramID 
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