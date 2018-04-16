CREATE procedure dbo.AddGrantInfoV2
(
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
		from Grantinfo(nolock)
		where VHCBName = @VHCBName 
			or GrantName = @GrantName
    )
	begin
		insert into Grantinfo(VHCBName, AwardAmt, BeginDate, EndDate, LkGrantAgency, GrantName, Admin, Match, Fundsrec,
		ContactID, AwardNum, CFDA, LkGrantSource, Staff, Program, FedFunds, DrawDown)
		values(@VHCBName, @AwardAmt, @BeginDate, @EndDate, @LkGrantAgency, @GrantName, @Admin, @Match, @Fundsrec,
		@ContactID, @AwardNum, @CFDA, @LkGrantSource, @Staff, @Program, @FedFunds, @DrawDown)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from Grantinfo(nolock)
		where VHCBName = @VHCBName 
			or GrantName = @GrantName
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