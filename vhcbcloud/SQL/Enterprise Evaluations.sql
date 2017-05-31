use vhcbsandbox
go

/* EnterpriseEvalMilestones */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEvalMilestonesList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEvalMilestonesList
go

create procedure dbo.GetEnterpriseEvalMilestonesList
(
	@ProjectID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesList 6657, 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, lv.Description as MilestoneDesc,
			MSDate, substring(Comment, 0, 25) ShortComment, Comment,
			LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName, 
			ep.RowIsActive
		from EnterpriseEvalMilestones ep(nolock)
		left join LookupValues lv(nolock) on typeid = ep.Milestone
		where ProjectID = @ProjectID
			and (@IsActiveOnly = 0 or ep.RowIsActive = @IsActiveOnly)
		order by EnterpriseEvalID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseEvalMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseEvalMilestones
go

create procedure dbo.AddEnterpriseEvalMilestones
(
	@ProjectID		int,
	@Milestone		int, 
	@MSDate			DateTime, 
	@Comment		nvarchar(max), 
	@LeadPlanAdvisorExp nvarchar(max), 
	@PlanProcess	bit, 
	@LoanReq	money, 
	@LoanRec	money, 
	@LoanPend	money,
	@GrantReq	money, 
	@GrantRec	money, 
	@GrantPend	money, 
	@OtherReq	money, 
	@OtherRec	money, 
	@OtherPend	money, 
	@SharedOutcome nvarchar(max), 
	@QuoteUse		int, 
	@QuoteName		nvarchar(25) = null,
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
		from EnterpriseEvalMilestones (nolock)
		where ProjectID = @ProjectID and Milestone = @Milestone
    )
	begin
		insert into EnterpriseEvalMilestones(ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, LoanReq, LoanRec, LoanPend, 
		GrantReq, GrantRec, GrantPend, OtherReq, OtherRec, OtherPend, SharedOutcome, QuoteUse, QuoteName)
		values(@ProjectID, @Milestone, @MSDate, @Comment, @LeadPlanAdvisorExp, @PlanProcess, @LoanReq, @LoanRec, @LoanPend, 
		@GrantReq, @GrantRec, @GrantPend, @OtherReq, @OtherRec, @OtherPend, @SharedOutcome, @QuoteUse, @QuoteName)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseEvalMilestones (nolock)
		where ProjectID = @ProjectID and Milestone = @Milestone
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseEvalMilestones]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseEvalMilestones
go

create procedure dbo.UpdateEnterpriseEvalMilestones
(
	@EnterpriseEvalID int,
	@Milestone		int,
	@MSDate			DateTime, 
	@Comment		nvarchar(max), 
	@LeadPlanAdvisorExp nvarchar(max), 
	@PlanProcess	bit, 
	@LoanReq	money, 
	@LoanRec	money, 
	@LoanPend	money,
	@GrantReq	money, 
	@GrantRec	money, 
	@GrantPend	money, 
	@OtherReq	money, 
	@OtherRec	money, 
	@OtherPend	money, 
	@SharedOutcome nvarchar(max), 
	@QuoteUse		int, 
	@QuoteName		nvarchar(25) = null,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEvalMilestones set Milestone = @Milestone, MSDate = @MSDate, Comment = @Comment, LeadPlanAdvisorExp = @LeadPlanAdvisorExp, PlanProcess = @PlanProcess, 
		LoanReq = @LoanReq, LoanRec = @LoanRec, LoanPend = @LoanPend, 
		GrantReq = @GrantReq, GrantRec = @GrantRec, GrantPend = @GrantPend, OtherReq = @OtherReq, OtherRec = @OtherRec, OtherPend = @OtherPend, 
		SharedOutcome = @SharedOutcome, QuoteUse = @QuoteUse, QuoteName = @QuoteName,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEvalMilestones 
	where EnterpriseEvalID = @EnterpriseEvalID

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEvalMilestonesById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEvalMilestonesById
go

create procedure dbo.GetEnterpriseEvalMilestonesById
(
	@EnterpriseEvalID	int
)
as
begin transaction
--exec GetEnterpriseEvalMilestonesById 1
	begin try
	
		select EnterpriseEvalID, ProjectID, Milestone, MSDate, Comment, LeadPlanAdvisorExp, PlanProcess, 
			convert(varchar(10), LoanReq) LoanReq, convert(varchar(10), LoanRec) LoanRec, LoanPend, 
			convert(varchar(10), GrantReq) GrantReq, convert(varchar(10), GrantRec) GrantRec, GrantPend,
			convert(varchar(10), OtherReq) OtherReq, convert(varchar(10), OtherRec) OtherRec, OtherPend, 
			SharedOutcome, QuoteUse, QuoteName, RowIsActive 
		from EnterpriseEvalMilestones ep(nolock)
		where EnterpriseEvalID = @EnterpriseEvalID
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

/* EnterpriseEvalMSSkillinfo */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseEvalMSSkillinfoList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseEvalMSSkillinfoList
go

create procedure dbo.GetEnterpriseEvalMSSkillinfoList
(
	@EnterPriseEvalID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseEvalMSSkillinfoList 1, 1
	begin try
	
		select EnterEvalSkillTypeID, SkillType, PreLevel, PostLevel, ms.RowIsActive,
		lv.Description as Skill, lv1.description as Pre, lv2.description as Post
		from EnterpriseEvalMSSkillinfo ms(nolock)
		left join LookupValues lv(nolock) on lv.typeid = SkillType
		left join LookupValues lv1(nolock) on lv1.typeid = PreLevel
		left join LookupValues lv2(nolock) on lv2.typeid = PostLevel
		where EnterPriseEvalID = @EnterPriseEvalID
			and (@IsActiveOnly = 0 or ms.RowIsActive = @IsActiveOnly)
		order by EnterPriseEvalID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseEvalMSSkillinfo]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseEvalMSSkillinfo
go

create procedure dbo.AddEnterpriseEvalMSSkillinfo
(
	@EnterPriseEvalID	int,
	@SkillType		int,
	@PreLevel		int,
	@PostLevel		int,
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
		from EnterpriseEvalMSSkillinfo (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and SkillType = @SkillType and PreLevel = @PreLevel and PostLevel = @PostLevel
    )
	begin
		insert into EnterpriseEvalMSSkillinfo(EnterPriseEvalID, SkillType, PreLevel, PostLevel)
		values(@EnterPriseEvalID, @SkillType, @PreLevel, @PostLevel)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseEvalMSSkillinfo (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and SkillType = @SkillType and PreLevel = @PreLevel and PostLevel = @PostLevel
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseEvalMSSkillinfo]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseEvalMSSkillinfo
go

create procedure dbo.UpdateEnterpriseEvalMSSkillinfo
(
	@EnterEvalSkillTypeID int,
	@SkillType		int,
	@PreLevel		int,
	@PostLevel		int,
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseEvalMSSkillinfo set SkillType = @SkillType, PreLevel = @PreLevel, PostLevel = @PostLevel,
		RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseEvalMSSkillinfo 
	where EnterEvalSkillTypeID = @EnterEvalSkillTypeID

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

/* EnterpriseBusPlanUse */

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEnterpriseBusPlanUseList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEnterpriseBusPlanUseList
go

create procedure dbo.GetEnterpriseBusPlanUseList
(
	@EnterpriseEvalID	int,
	@IsActiveOnly	bit
)
as
begin transaction
--exec GetEnterpriseBusPlanUseList 1, 1
	begin try
	
		select EnterBusPlanUseID, EnterpriseEvalID, LKBusPlanUsage, bp.RowIsActive,
		lv.Description as BusPlanUsage
		from EnterpriseBusPlanUse bp(nolock)
		left join LookupValues lv(nolock) on lv.typeid = LKBusPlanUsage
		where EnterpriseEvalID = @EnterpriseEvalID
			and (@IsActiveOnly = 0 or bp.RowIsActive = @IsActiveOnly)
		order by EnterBusPlanUseID desc
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddEnterpriseBusPlanUse]') and type in (N'P', N'PC'))
drop procedure [dbo].AddEnterpriseBusPlanUse
go

create procedure dbo.AddEnterpriseBusPlanUse
(
	@EnterPriseEvalID	int,
	@LKBusPlanUsage		int,
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
		from EnterpriseBusPlanUse (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and LKBusPlanUsage = @LKBusPlanUsage
    )
	begin
		insert into EnterpriseBusPlanUse(EnterpriseEvalID, LKBusPlanUsage)
		values(@EnterPriseEvalID, @LKBusPlanUsage)
		
		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive
		from EnterpriseBusPlanUse (nolock)
		where EnterPriseEvalID = @EnterPriseEvalID and LKBusPlanUsage = @LKBusPlanUsage
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateEnterpriseBusPlanUse]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateEnterpriseBusPlanUse
go

create procedure dbo.UpdateEnterpriseBusPlanUse
(
	@EnterBusPlanUseID int,
	--LKBusPlanUsage
	@RowIsActive		bit
) as
begin transaction

	begin try
	
	update EnterpriseBusPlanUse set RowIsActive = @RowIsActive, DateModified = getdate()
	from EnterpriseBusPlanUse 
	where EnterBusPlanUseID = @EnterBusPlanUseID

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