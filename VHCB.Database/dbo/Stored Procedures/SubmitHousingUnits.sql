CREATE procedure SubmitHousingUnits
(
	@HousingID		int,
	@LkHouseCat		int,
	--@TotalUnits		int,
	@Hsqft			int,
	@Previous		int,
	@NewUnits		int,
	@UnitsRemoved	int,
	@MHIP			int,
	@IsSash			bit,
	@ServSuppUnits	int,
	@Bldgs			int

) as
begin transaction

	begin try

	update Housing set LkHouseCat = @LkHouseCat, TotalUnits = @Previous + @NewUnits - @UnitsRemoved, Hsqft = @Hsqft, 
	Previous = @Previous, NewUnits = @NewUnits, UnitsRemoved = @UnitsRemoved, Vermod = @MHIP, Sash = @IsSash, 
	ServSuppUnits = @ServSuppUnits, Bldgs = @Bldgs
	
	from Housing(nolock) 
	where HousingID = @HousingID

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