
create procedure dbo.UpdateEnterpriseServProviderData
(
	@EnterpriseMasterServiceProvID		int,
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
	@Notes					nvarchar(max),

	@BusPlans1				int, 
	@BusPlanProjCost1		money, 
	@CashFlows1				int, 
	@CashFlowProjCost1		money,
	@Yr2Followup1			int, 
	@Yr2FollowUpProjCost1	money, 
	@AddEnrollees1			int, 
	@AddEnrolleeProjCost1	money, 
	@WorkshopsEvents1		int, 
	@WorkShopEventProjCost1	money, 
	@SplProjects1			nvarchar(max),
	@Notes1					nvarchar(max),

	@RowIsActive		bit
) as
begin transaction

	begin try
	
	declare @EnterServiceProvID int

	select @EnterServiceProvID = EnterServiceProvID
	from EnterpriseServProviderData
	where EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID and PrePost = 1

	update EnterpriseServProviderData set 
		BusPlans = @BusPlans, BusPlanProjCost = @BusPlanProjCost, CashFlows = @CashFlows, 
		CashFlowProjCost = @CashFlowProjCost, Yr2Followup = @Yr2Followup, Yr2FollowUpProjCost = @Yr2FollowUpProjCost, 
		AddEnrollees = @AddEnrollees, AddEnrolleeProjCost = @AddEnrolleeProjCost, WorkshopsEvents = @WorkshopsEvents, 
		WorkShopEventProjCost = @WorkShopEventProjCost, Notes = @Notes, SpecialProj = @SplProjects, 
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseServProviderData 
	where EnterServiceProvID = @EnterServiceProvID

	select @EnterServiceProvID = EnterServiceProvID
	from EnterpriseServProviderData
	where EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID and PrePost = 2

	update EnterpriseServProviderData set 
		BusPlans = @BusPlans1, BusPlanProjCost = @BusPlanProjCost1, CashFlows = @CashFlows1, 
		CashFlowProjCost = @CashFlowProjCost1, Yr2Followup = @Yr2Followup1, Yr2FollowUpProjCost = @Yr2FollowUpProjCost1, 
		AddEnrollees = @AddEnrollees1, AddEnrolleeProjCost = @AddEnrolleeProjCost1, WorkshopsEvents = @WorkshopsEvents1, 
		WorkShopEventProjCost = @WorkShopEventProjCost1, Notes = @Notes1, SpecialProj = @SplProjects1,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseServProviderData 
	where EnterServiceProvID = @EnterServiceProvID

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