
create procedure dbo.UpdateAct250Farm
(
	@Act250FarmID	int,
	@LkTownDev		int, 
	@CDist			int, 
	@Type			int, 
	@DevName		nvarchar(50), 
	@Primelost		int, 
	@Statelost		int, 
	@TotalAcreslost	int, 
	@AcresDevelop	int, 
	@Developer		int, 
	@AntFunds		money, 
	@MitDate		datetime, 
	@URL			nvarchar(1500),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update Act250Farm set LkTownDev = @LkTownDev, CDist = @CDist, Type = @Type, DevName = @DevName, Primelost = @Primelost, Statelost = @Statelost, 
		TotalAcreslost = @TotalAcreslost, AcresDevelop = @AcresDevelop, Developer = @Developer, AntFunds = @AntFunds, MitDate = @MitDate,
		RowIsActive = @IsRowIsActive, URL = @URL, DateModified = getdate()
	from Act250Farm
	where Act250FarmID = @Act250FarmID
	
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