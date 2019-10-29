
create procedure dbo.AddEnterpriseServProviderData
(
	@ProjectID				int, 
	@Year					nvarchar(10), 
	@PrePost				int,

	@BusPlans				int, 
	@BusPlanProjCost		money, 
	@CashFlows				int, 
	@CashFlowProjCost		money,
	@Yr2Followup			int, 
	@Yr2FollowUpProjCost	money, 
	@AddEnrollees			int, 
	@AddEnrolleeProjCost	money, 
	@WorkshopsEvents		int, 
	@WorkShopEventProjCost	money, 
	@SplProjects			nvarchar(max),
	@Notes					nvarchar(max)
) as
begin transaction

	begin try

	declare @EnterpriseMasterServiceProvID int

	if not exists
    (
		select 1
		from EnterpriseMasterServiceProvider(nolock)
		where ProjectID = @ProjectID and Year = @Year
    )
	begin
		insert into EnterpriseMasterServiceProvider(ProjectID, Year)
		values(@ProjectID, @Year)

		set @EnterpriseMasterServiceProvID = @@Identity
	end
	else
	begin
		select @EnterpriseMasterServiceProvID = EnterpriseMasterServiceProvID
		from EnterpriseMasterServiceProvider(nolock)
		where ProjectID = @ProjectID and Year = @Year
	end

	declare @EnterServiceProvID int

	if not exists
	(
		select 1 
		from EnterpriseServProviderData(nolock)
		where EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID and PrePost = @PrePost
	)
	begin
		insert into EnterpriseServProviderData(EnterpriseMasterServiceProvID, PrePost, BusPlans, BusPlanProjCost, CashFlows, CashFlowProjCost, Yr2Followup, Yr2FollowUpProjCost, AddEnrollees, AddEnrolleeProjCost, WorkshopsEvents, WorkShopEventProjCost, SpecialProj, Notes)
		values(@EnterpriseMasterServiceProvID, @PrePost, @BusPlans, @BusPlanProjCost, @CashFlows, @CashFlowProjCost, @Yr2Followup, @Yr2FollowUpProjCost, @AddEnrollees, @AddEnrolleeProjCost, @WorkshopsEvents, @WorkShopEventProjCost, @SplProjects, @Notes)
	end
	else
	begin
		select @EnterServiceProvID = EnterServiceProvID
		from EnterpriseServProviderData(nolock)
		where EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID and PrePost = @PrePost

		update EnterpriseServProviderData set 
			BusPlans = @BusPlans, BusPlanProjCost = @BusPlanProjCost, CashFlows = @CashFlows, 
			CashFlowProjCost = @CashFlowProjCost, Yr2Followup = @Yr2Followup, Yr2FollowUpProjCost = @Yr2FollowUpProjCost, 
			AddEnrollees = @AddEnrollees, AddEnrolleeProjCost = @AddEnrolleeProjCost, WorkshopsEvents = @WorkshopsEvents, 
			WorkShopEventProjCost = @WorkShopEventProjCost, Notes = @Notes, RowIsActive = 1, DateModified = getdate()
		from EnterpriseServProviderData 
		where EnterServiceProvID = @EnterServiceProvID
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