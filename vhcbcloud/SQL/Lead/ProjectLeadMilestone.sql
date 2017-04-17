use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadMilestoneById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadMilestoneById
go

create procedure GetProjectLeadMilestoneById  
(
	@LeadMilestoneID	int
)
as
begin
--exec GetProjectLeadMilestoneById 1
	select LeadMilestoneID, ProjectID, LKMilestone, LeadBldgID, LeadUnitID, MSDate, URL, RowIsActive
	from ProjectLeadMilestone(nolock)
	where LeadMilestoneID = @LeadMilestoneID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectLeadMilestoneList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectLeadMilestoneList
go

create procedure GetProjectLeadMilestoneList  
(
	@ProjectId		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectLeadMilestoneList 6625, 1
	select LeadMilestoneID, LKMilestone, lv.Description as Milestone, plm.LeadBldgID, plb.Building, plm.LeadUnitID, plu.Unit, MSDate, 
	URL, CASE when isnull(URL, '') = '' then '' else 'Click here' end as URLText, plm.RowIsActive
	from ProjectLeadMilestone plm(nolock)
	join ProjectLeadBldg plb(nolock) on plb.LeadBldgID = plm.LeadBldgID
	left join ProjectLeadUnit plu(nolock) on plu.LeadUnitID = plm.LeadUnitID
	left join LookupValues lv(nolock) on lv.TypeID = plm.LKMilestone
	where plm.ProjectId = @ProjectId
		and (@IsActiveOnly = 0 or plm.RowIsActive = @IsActiveOnly)
	order by plm.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectLeadMilestone]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectLeadMilestone
go

create procedure dbo.AddProjectLeadMilestone
(
	@ProjectID		int, 
	@LKMilestone	int, 
	@LeadBldgID		int, 
	@LeadUnitID		int, 
	@MSDate			datetime,
	@URL			nvarchar(1500),
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
		from ProjectLeadMilestone (nolock)
		where ProjectID = @ProjectID and LKMilestone = @LKMilestone
	)
	begin
		insert into ProjectLeadMilestone(ProjectID, LKMilestone, LeadBldgID, LeadUnitID, MSDate, URL)
		values(@ProjectID, @LKMilestone, @LeadBldgID, @LeadUnitID, @MSDate, @URL)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectLeadMilestone (nolock)
		where ProjectID = @ProjectID and LKMilestone = @LKMilestone
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectLeadMilestone]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectLeadMilestone
go

create procedure dbo.UpdateProjectLeadMilestone
(
	@LeadMilestoneID	int,
	@LKMilestone		int, 
	@LeadBldgID			int, 
	@LeadUnitID			int, 
	@URL				nvarchar(1500),
	@MSDate				datetime,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectLeadMilestone set LKMilestone = LKMilestone, LeadBldgID = @LeadBldgID, LeadUnitID = @LeadUnitID, MSDate = @MSDate, URL = @URL,
		RowIsActive = @IsRowIsActive
	where LeadMilestoneID = @LeadMilestoneID

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