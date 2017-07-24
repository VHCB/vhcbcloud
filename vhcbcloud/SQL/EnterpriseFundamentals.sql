use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseFundamentals]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseFundamentals
go

create  procedure GetEnterpriseFundamentals
(
	@ProjectID		int
)  
as 
--exec GetEnterpriseFundamentals 2790
begin
	select  EnterFundamentalID, efd.ProjectID, PlanType, BusPlan, Grantapp,
		ServiceProvOrg, 
		LeadAdvisor, 
		ProjDesc, BusDesc, efd.RowIsActive, LkProgram, lv2.Description 'ProjectProgram'
	from EnterpriseFundamentals efd(nolock)
	join Project p(nolock) on efd.ProjectID = p.ProjectId
	left join LookupValues lv(nolock) on lv.TypeID = efd.PlanType
	--left join LookupValues lv1(nolock) on lv1.TypeID = efd.HearAbout
	left join LookupValues lv2(nolock) on lv2.TypeID = LkProgram
	where efd.ProjectID = @ProjectID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseFundamentals]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseFundamentals
go

create procedure dbo.AddEnterpriseFundamentals
(
	@ProjectID		int, 
	@PlanType		int = null,
	@ServiceProvOrg	int = null,
	@LeadAdvisor	int = null,
	@HearAbout		int = null,
	@ProjDesc		nvarchar(max) = null, 
	@BusDesc		nvarchar(max) = null, 
	@YrManageBus	nvarchar(10) = null, 
	@BusPlan		bit,
	@Grantapp		bit,
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
		insert into EnterpriseFundamentals(ProjectID, PlanType, ServiceProvOrg, LeadAdvisor, ProjDesc, BusDesc, BusPlan, Grantapp)
		values(@ProjectID, @PlanType, @ServiceProvOrg, @LeadAdvisor, @ProjDesc, @BusDesc, @BusPlan, @Grantapp)
		
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseFundamentals]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseFundamentals
go

create procedure dbo.UpdateEnterpriseFundamentals
(
	@EnterFundamentalID	int,
	@PlanType		int = null,
	@ServiceProvOrg	int = null,
	@LeadAdvisor	int = null,
	@ProjDesc		nvarchar(max) = null, 
	@BusDesc		nvarchar(max) = null, 
	@Grantapp		bit,
	@BusPlan		bit,
	@RowIsActive	bit
) as
begin transaction

	begin try
	
	update EnterpriseFundamentals set 
		PlanType = @PlanType, 
		ServiceProvOrg = @ServiceProvOrg, 
		LeadAdvisor = @LeadAdvisor, 
		ProjDesc = @ProjDesc, 
		BusDesc = @BusDesc, 
		BusPlan = @BusPlan, 
		Grantapp = @Grantapp,
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
go

/* EnterpriseFinancialJobs */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseFinancialJobs]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseFinancialJobs
go

create procedure dbo.AddEnterpriseFinancialJobs
(
	@ProjectID		int, 
	@MilestoneID	int = null,
	@MSDate			date = null,
	@Year			nchar(10),
	@GrossSales		money,
	@Netincome		money,
	@GrossPayroll	money,
	@FamilyEmp		int,
	@NonFamilyEmp	int,
	@Networth		money,
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
		from EnterpriseFinancialJobs(nolock)
		where ProjectID = @ProjectID and MilestoneID = @MilestoneID
    )
	begin
		insert into EnterpriseFinancialJobs(ProjectID, MilestoneID, MSDate, Year, GrossSales, Netincome, GrossPayroll, FamilyEmp, NonFamilyEmp, Networth)
		values(@ProjectID, @MilestoneID, @MSDate, @Year, @GrossSales, @Netincome, @GrossPayroll, @FamilyEmp, @NonFamilyEmp, @Networth)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseFinancialJobs(nolock)
		where ProjectID = @ProjectID  and MilestoneID = @MilestoneID
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseFinancialJobs]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseFinancialJobs
go

create procedure dbo.UpdateEnterpriseFinancialJobs
(
	@EnterFinancialJobsID	int,
	@MilestoneID	int = null,
	@MSDate			date = null,
	@Year			nchar(10),
	@GrossSales		money,
	@Netincome		money,
	@GrossPayroll	money,
	@FamilyEmp		int,
	@NonFamilyEmp	int,
	@Networth		money,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseFinancialJobs set 
		MilestoneID = @MilestoneID,
		MSDate = @MSDate,
		Year = @Year,
		GrossSales = @GrossSales,
		Netincome = @Netincome,
		GrossPayroll = @GrossPayroll,
		FamilyEmp = @FamilyEmp,
		NonFamilyEmp = @NonFamilyEmp,
		Networth = @Networth,
		RowIsActive = @RowIsActive, 
		DateModified = getdate()
	from EnterpriseFinancialJobs 
	where EnterFinancialJobsID = @EnterFinancialJobsID

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseFinancialJobsById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseFinancialJobsById
go

create procedure GetEnterpriseFinancialJobsById
(
	@EnterFinancialJobsID		int
)  
as 
--exec GetEnterpriseFinancialJobsById 2790
begin
	select EnterFinancialJobsID, MilestoneID, MSDate, Year, 
	convert(varchar(10), GrossSales) GrossSales, convert(varchar(10), Netincome) Netincome, 
	convert(varchar(10), GrossPayroll) GrossPayroll, FamilyEmp, NonFamilyEmp, 
	convert(varchar(10), Networth) Networth,
	efj.RowIsActive, efj.DateModified 
	from EnterpriseFinancialJobs efj(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = efj.MilestoneID
	where efj.EnterFinancialJobsID = @EnterFinancialJobsID
end
go


if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseFinancialJobsList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseFinancialJobsList
go

create procedure dbo.GetEnterpriseFinancialJobsList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseFinancialJobsList 1, 1
	begin try
	
		select EnterFinancialJobsID, MilestoneID, MSDate, Year, GrossSales, Netincome, GrossPayroll, FamilyEmp, NonFamilyEmp, 
		efj.RowIsActive, lv.Description as Milestone 
		from EnterpriseFinancialJobs efj(nolock)
		left join LookupValues lv(nolock) on lv.TypeID = efj.MilestoneID
		where efj.ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or efj.RowIsActive = @IsActiveOnly)
		order by EnterFinancialJobsID desc
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
go

/* EnterpriseServProviderData */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseServProviderData]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseServProviderData
go

create procedure dbo.AddEnterpriseServProviderData
(
	@ProjectID				int, 
	@Year					nvarchar(10), 
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
	@isDuplicate			bit output,
	@isActive				bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1
		from EnterpriseMasterServiceProvider(nolock)
		where ProjectID = @ProjectID and Year = @Year
    )
	begin
		declare @EnterpriseMasterServiceProvID int
		insert into EnterpriseMasterServiceProvider(ProjectID, Year)
		values(@ProjectID, @Year)

		set @EnterpriseMasterServiceProvID = @@Identity

		insert into EnterpriseServProviderData(EnterpriseMasterServiceProvID, PrePost, BusPlans, BusPlanProjCost, CashFlows, CashFlowProjCost, Yr2Followup, Yr2FollowUpProjCost, AddEnrollees, AddEnrolleeProjCost, WorkshopsEvents, WorkShopEventProjCost, SpecialProj, Notes)
		values(@EnterpriseMasterServiceProvID, 1, @BusPlans, @BusPlanProjCost, @CashFlows, @CashFlowProjCost, @Yr2Followup, @Yr2FollowUpProjCost, @AddEnrollees, @AddEnrolleeProjCost, @WorkshopsEvents, @WorkShopEventProjCost, @SplProjects, @Notes)
		
		insert into EnterpriseServProviderData(EnterpriseMasterServiceProvID, PrePost, BusPlans, BusPlanProjCost, CashFlows, CashFlowProjCost, Yr2Followup, Yr2FollowUpProjCost, AddEnrollees, AddEnrolleeProjCost, WorkshopsEvents, WorkShopEventProjCost, SpecialProj, Notes)
		values(@EnterpriseMasterServiceProvID, 2, @BusPlans1, @BusPlanProjCost1, @CashFlows1, @CashFlowProjCost1, @Yr2Followup1, @Yr2FollowUpProjCost1, @AddEnrollees1, @AddEnrolleeProjCost1, @WorkshopsEvents1, @WorkShopEventProjCost1, @SplProjects1, @Notes1)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseMasterServiceProvider(nolock)
		where ProjectID = @ProjectID and Year = @Year
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseServProviderData]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseServProviderData
go

create procedure dbo.UpdateEnterpriseServProviderData
(
	@EnterServiceProvID		int,
	@Year					nvarchar(10), 
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
	@Notes					nvarchar(max),
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseServProviderData set 
		Year = @Year, BusPlans = @BusPlans, BusPlanProjCost = @BusPlanProjCost, CashFlows = @CashFlows, 
		CashFlowProjCost = @CashFlowProjCost, Yr2Followup = @Yr2Followup, Yr2FollowUpProjCost = @Yr2FollowUpProjCost, 
		AddEnrollees = @AddEnrollees, AddEnrolleeProjCost = @AddEnrolleeProjCost, WorkshopsEvents = @WorkshopsEvents, 
		WorkShopEventProjCost = @WorkShopEventProjCost, Notes = @Notes, RowIsActive = @RowIsActive, DateModified = getdate()
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseServProviderDataById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseServProviderDataById
go

create procedure GetEnterpriseServProviderDataById
(
	@EnterpriseMasterServiceProvID		int
)  
as 
--exec GetEnterpriseServProviderDataById 1
begin
	select m.ProjectID, m.Year, c.PrePost, 
	c.BusPlans, convert(varchar(10), c.BusPlanProjCost) BusPlanProjCost, 
	c.CashFlows, convert(varchar(10), c.CashFlowProjCost) CashFlowProjCost, 
	c.Yr2Followup, convert(varchar(10), c.Yr2FollowUpProjCost) Yr2FollowUpProjCost, 
	c.AddEnrollees, convert(varchar(10), c.AddEnrolleeProjCost) AddEnrolleeProjCost, 
	c.WorkshopsEvents, convert(varchar(10), c.WorkShopEventProjCost) WorkShopEventProjCost, 
	c.SpecialProj, c.Notes 
	from EnterpriseMasterServiceProvider m(nolock)
	join EnterpriseServProviderData c(nolock) on m.EnterpriseMasterServiceProvID = c.EnterpriseMasterServiceProvID
	where m.EnterpriseMasterServiceProvID = @EnterpriseMasterServiceProvID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseServProviderDataList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseServProviderDataList
go

create procedure dbo.GetEnterpriseServProviderDataList
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseServProviderDataList 1, 1
	begin try
	
		select EnterpriseMasterServiceProvID, ProjectID, Year, RowIsActive
		from EnterpriseMasterServiceProvider (nolock)
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
		order by year desc

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
go

/* Attribute */
if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseEngagementAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseEngagementAttributes
go

create procedure dbo.AddEnterpriseEngagementAttributes
(
	@EnterFundamentalID		int,
	@LKAttributeID	int,
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
		from EnterpriseEngagementAttributes(nolock)
		where EnterFundamentalID = @EnterFundamentalID 
			and LKAttributeID = @LKAttributeID
    )
	begin
		insert into EnterpriseEngagementAttributes(EnterFundamentalID, LKAttributeID, DateModified)
		values(@EnterFundamentalID, @LKAttributeID, getdate())
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseEngagementAttributes(nolock)
		where EnterFundamentalID = @EnterFundamentalID 
			and LKAttributeID = @LKAttributeID
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseEngagementAttributes]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseEngagementAttributes
go

create procedure dbo.UpdateEnterpriseEngagementAttributes
(
	@EnterEngageAttrID	int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEngagementAttributes set  RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEngagementAttributes 
	where EnterEngageAttrID = @EnterEngageAttrID

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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEngagementAttributesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEngagementAttributesList
go

create procedure GetEnterpriseEngagementAttributesList
(
	@EnterFundamentalID		int,
	@IsActiveOnly	bit
)  
as
--exec GetEnterpriseEngagementAttributesList 1, 1
begin
	select  ca.EnterEngageAttrID, ca.LKAttributeID, lv.Description as Attribute, ca.RowIsActive
	from EnterpriseEngagementAttributes ca(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = ca.LKAttributeID
	where ca.EnterFundamentalID = @EnterFundamentalID
	and (@IsActiveOnly = 0 or ca.RowIsActive = @IsActiveOnly)
		order by ca.DateModified desc
end
go