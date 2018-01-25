
create procedure SubmitConserve
(
	@ProjectID		int,
	@LkConsTrack	int,
	@NumEase		int,
	@PrimStew		int,
	@TotalAcres		decimal(18, 2),
	@Wooded			decimal(18, 2),
	@Prime			decimal(18, 2),
	@Statewide		decimal(18, 2), 
	@Tillable		decimal(18, 2),
	@Pasture		decimal(18, 2), 
	@Unmanaged		decimal(18, 2),
	@FarmResident	decimal(18, 2),
	@NaturalRec		decimal(18, 2),
	@UserID			int
)
as
--exec SubmitConserve
begin
	begin try

	declare @ConserveID int

	if not exists
    (
		select 1
		from Conserve(nolock)
		where ProjectID = @ProjectId
    )
	begin
		insert into Conserve(ProjectID, LkConsTrack, PrimStew, NumEase, TotalAcres, Wooded, Prime, Statewide, 
		Tillable, Pasture, Unmanaged, FarmResident, NaturalRec, UserID, DateModified)
		values(@ProjectID, @LkConsTrack, @PrimStew, @NumEase, @TotalAcres, @Wooded, @Prime, @Statewide, 
		@Tillable, @Pasture, @Unmanaged, @FarmResident, @NaturalRec, @UserID, getdate())

		set @ConserveID = @@IDENTITY

		exec dbo.AddConserveEholder @ProjectID, @PrimStew, null, null
	end
	else
	begin
		update Conserve set LkConsTrack = @LkConsTrack, PrimStew = @PrimStew, NumEase = @NumEase, TotalAcres = @TotalAcres, 
			Wooded = @Wooded, Prime = @Prime, Statewide = @Statewide, 
			Tillable = @Tillable, Pasture = @Pasture, Unmanaged = @Unmanaged, FarmResident = @FarmResident, NaturalRec = @NaturalRec,
			UserID = @UserID, DateModified = getdate()
		from Conserve
		where ProjectID = @ProjectId 

		exec dbo.AddConserveEholder @ProjectID, @PrimStew, null, null
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
end