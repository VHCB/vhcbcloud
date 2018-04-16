CREATE procedure dbo.UpdateGrantInfoV2
(
	@GrantinfoID	int,
	@VHCBName		nvarchar(50),
	@AwardAmt		decimal(16, 2),
	@BeginDate		datetime = null,
	@EndDate		datetime = null,
	@LkGrantAgency	int = null,
	@GrantName		nvarchar(50),
	@ContactID		int = null,
	@AwardNum		nvarchar(25) = null,
	@CFDA			nchar(5) = null,
	@LkGrantSource	int = null, --Grant Type
	@Staff			int = null,
	@Program		int = null,
	@FedFunds		bit,
	@Admin			bit,
	@Match			bit,
	@DrawDown		bit,
	@Fundsrec		bit,
	@RowIsActive	bit
) as
begin transaction

	begin try
	begin
		update Grantinfo set VHCBName = @VHCBName, AwardAmt = @AwardAmt, BeginDate = @BeginDate, EndDate = @EndDate, 
		LkGrantAgency = @LkGrantAgency, GrantName = @GrantName, Admin = @Admin, Match = @Match, Fundsrec = @Fundsrec,
		ContactID = @ContactID, AwardNum = @AwardNum, CFDA = @CFDA, LkGrantSource = @LkGrantSource, Staff = @Staff, 
		Program = @Program, FedFunds = @FedFunds, RowIsActive = @RowIsActive, DrawDown = @DrawDown
		from Grantinfo where GrantinfoID = @GrantinfoID
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