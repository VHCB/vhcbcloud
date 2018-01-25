CREATE procedure dbo.UpdateEnterpriseImpGrants
(
	@EnterImpGrantID	int,
	@OtherNames		nvarchar(150),
	@FYGrantRound	int, 
	@ProjTitle		nvarchar(80), 
	@ProjDesc		nvarchar(max), 
	@ProjCost		money, 
	@Request		money, 
	@AwardAmt		money, 
	@AwardDesc		nvarchar(max), 
	@LeveragedFunds	money, 
	@Comments		nvarchar(max),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseImpGrants set 
		FYGrantRound = @FYGrantRound, ProjTitle = @ProjTitle, OtherNames = @OtherNames,
		ProjDesc = @ProjDesc, ProjCost = @ProjCost, Request = @Request, AwardAmt = @AwardAmt, 
		AwardDesc = @AwardDesc, LeveragedFunds = @LeveragedFunds, Comments = @Comments,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseImpGrants 
	where EnterImpGrantID = @EnterImpGrantID

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