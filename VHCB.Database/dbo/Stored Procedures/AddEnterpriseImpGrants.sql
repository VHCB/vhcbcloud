CREATE procedure dbo.AddEnterpriseImpGrants
( 
	@ProjectID		int, 
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
		from EnterpriseImpGrants(nolock)
		where ProjectID = @ProjectID 
    )
	begin
		insert into EnterpriseImpGrants(ProjectID, FYGrantRound, ProjTitle, ProjDesc, ProjCost, Request, AwardAmt, AwardDesc, LeveragedFunds, Comments, OtherNames)
		values(@ProjectID, @FYGrantRound, @ProjTitle, @ProjDesc, @ProjCost, @Request, @AwardAmt, @AwardDesc, @LeveragedFunds, @Comments, @OtherNames)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseImpGrants(nolock)
		where ProjectID = @ProjectID 
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