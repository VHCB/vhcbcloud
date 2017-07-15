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
	select  EnterFundamentalID, efd.ProjectID, PlanType,
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
		insert into EnterpriseFundamentals(ProjectID, PlanType, ServiceProvOrg, LeadAdvisor, HearAbout, ProjDesc, BusDesc, YrManageBus)
		values(@ProjectID, @PlanType, @ServiceProvOrg, @LeadAdvisor, @HearAbout, @ProjDesc, @BusDesc, @YrManageBus)
		
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
	@HearAbout		int = null,
	@ProjDesc		nvarchar(max) = null, 
	@BusDesc		nvarchar(max) = null, 
	@YrManageBus	nvarchar(10) = null, 
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseFundamentals set 
		PlanType = @PlanType, 
		ServiceProvOrg = @ServiceProvOrg, 
		LeadAdvisor = @LeadAdvisor, 
		HearAbout = @HearAbout, 
		ProjDesc = @ProjDesc, 
		BusDesc = @BusDesc, 
		YrManageBus = @YrManageBus, 
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
	@Notes					nvarchar(max),
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
		from EnterpriseServProviderData(nolock)
		where ProjectID = @ProjectID and Year = @Year
    )
	begin
		insert into EnterpriseServProviderData(ProjectID, Year, BusPlans, BusPlanProjCost, CashFlows, CashFlowProjCost, Yr2Followup, Yr2FollowUpProjCost, AddEnrollees, AddEnrolleeProjCost, WorkshopsEvents, WorkShopEventProjCost, Notes)
		values(@ProjectID, @Year, @BusPlans, @BusPlanProjCost, @CashFlows, @CashFlowProjCost, @Yr2Followup, @Yr2FollowUpProjCost, @AddEnrollees, @AddEnrolleeProjCost, @WorkshopsEvents, @WorkShopEventProjCost, @Notes)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseServProviderData(nolock)
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
	@EnterServiceProvID		int
)  
as 
--exec GetEnterpriseServProviderDataById 2790
begin
	select EnterServiceProvID, ProjectID, Year, 
	BusPlans, convert(varchar(10), BusPlanProjCost) BusPlanProjCost, 
	CashFlows, convert(varchar(10), CashFlowProjCost) CashFlowProjCost, 
	Yr2Followup, convert(varchar(10), Yr2FollowUpProjCost) Yr2FollowUpProjCost, 
	AddEnrollees, convert(varchar(10), AddEnrolleeProjCost) AddEnrolleeProjCost, 
	WorkshopsEvents, convert(varchar(10), WorkShopEventProjCost) WorkShopEventProjCost, 
	Notes, RowIsActive, DateModified 
	from EnterpriseServProviderData (nolock)
	where EnterServiceProvID = @EnterServiceProvID
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
	
		select EnterServiceProvID, ProjectID, Year, 
			BusPlans, convert(varchar(10), BusPlanProjCost) BusPlanProjCost, 
			CashFlows, convert(varchar(10), CashFlowProjCost) CashFlowProjCost, 
			Yr2Followup, convert(varchar(10), Yr2FollowUpProjCost) Yr2FollowUpProjCost, 
			AddEnrollees, convert(varchar(10), AddEnrolleeProjCost) AddEnrolleeProjCost, 
			WorkshopsEvents, convert(varchar(10), WorkShopEventProjCost) WorkShopEventProjCost, 
			Notes, RowIsActive, DateModified 
		from EnterpriseServProviderData (nolock)
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly)
		order by EnterServiceProvID desc

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