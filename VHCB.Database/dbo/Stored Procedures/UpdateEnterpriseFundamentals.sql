CREATE procedure dbo.UpdateEnterpriseFundamentals
(
	@EnterFundamentalID	int,
	@FiscalYr		int,
	@PlanType		int = null,
	@ServiceProvOrg	int = null,
	@LeadAdvisor	int = null,
	@ProjDesc		nvarchar(max) = null, 
	@BusDesc		nvarchar(max) = null, 
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update EnterpriseFundamentals set 
		FiscalYr = @FiscalYr,
		PlanType = @PlanType, 
		ServiceProvOrg = @ServiceProvOrg, 
		LeadAdvisor = @LeadAdvisor, 
		ProjDesc = @ProjDesc, 
		BusDesc = @BusDesc, 
		RowIsActive = @RowIsActive, 
		DateModified = getdate()
	from EnterpriseFundamentals 
	where EnterFundamentalID = @EnterFundamentalID

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