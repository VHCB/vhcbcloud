
create procedure dbo.AddAct250Farm
(
	@UsePermit		nvarchar(12), 
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
		from Act250Farm(nolock)
		where UsePermit = @UsePermit 
	)
	begin

		insert into Act250Farm(UsePermit, LkTownDev, CDist, Type, DevName, Primelost, Statelost, TotalAcreslost, 
			AcresDevelop, Developer, AntFunds, MitDate, URL)
		values(@UsePermit, @LkTownDev, @CDist, @Type, @DevName, @Primelost, @Statelost, @TotalAcreslost, 
			@AcresDevelop, @Developer, @AntFunds, @MitDate, @URL)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from Act250Farm(nolock)
		where UsePermit = @UsePermit
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