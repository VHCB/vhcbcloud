CREATE procedure dbo.AddEnterpriseFundamentals
(
	@ProjectID		int, 
	@FiscalYr		int = null,
	@PlanType		int = null,
	@ServiceProvOrg	int = null,
	@LeadAdvisor	int = null,
	@HearAbout		int = null,
	@ProjDesc		nvarchar(max) = null, 
	@BusDesc		nvarchar(max) = null, 
	@YrManageBus	nvarchar(10) = null, 
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
		from EnterpriseFundamentals(nolock)
		where ProjectID = @ProjectID 
    )
	begin
		insert into EnterpriseFundamentals(ProjectID, FiscalYr, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc)
		values(@ProjectID, @FiscalYr, @PlanType, @ServiceProvOrg, @LeadAdvisor, @ProjDesc, @BusDesc)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseFundamentals(nolock)
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