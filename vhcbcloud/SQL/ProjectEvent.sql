use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectEventList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectEventList
go

create procedure GetProjectEventList  
(
	@ProjectID		int,
	@IsActiveOnly	bit
)
as
begin
--exec GetProjectEventList 1, 1
	select pe.ProjectEventID, 
		pe.Prog, lv.Description as Program, 
		pe.ProjectID, p.project_name, 
		pe.ApplicantID, an.applicantname, 
		pe.EventID, lv1.Description as Event, 
		pe.SubEventID, lv2.Description as SubEvent,
		pe.Date,
		substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes,
		pe.UserID, ui.username, 
		pe.RowIsActive
	from ProjectEvent pe(nolock)
	left join project_v p(nolock) on pe.ProjectID = p.project_id and p.defname = 1
	left join applicantappname aan(nolock) on pe.ApplicantId = aan.ApplicantID
	left join appname an(nolock) on aan.appnameid = an.appnameid
	left join applicant a(nolock) on a.applicantid = aan.applicantid
	left join LookupValues lv(nolock) on lv.TypeID = pe.Prog
	left join LookupValues lv1(nolock) on lv1.TypeID = pe.EventID
	left join LookupValues lv2(nolock) on lv2.TypeID = pe.SubEventID
	left join userinfo ui(nolock) on ui.userid = pe.UserId
	where isnull(pe.ProjectID, 0) = @ProjectID
		and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
	order by pe.DateModified desc
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddProjectEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].AddProjectEvent
go

create procedure dbo.AddProjectEvent
(
	@Prog			int, 
	@ProjectID		int, 
	@ApplicantID	int, 
	@EventID		int, 
	@SubEventID		int, 
	@Date			datetime, 
	@Note			nvarchar(max), 
	@UserID			int,
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try

	set @isDuplicate = 1
	set @isActive = 1
	
	declare @AppNameID int
	set @AppNameID = @ApplicantID
	set @ApplicantID = 0
	select @ApplicantID = ApplicantID from ApplicantAppName(nolock) where AppNameID = @AppNameID

	if not exists
    (
		select 1 
		from ProjectEvent(nolock)
		where Prog = @Prog 
			and ProjectID = @ProjectID 
			and ApplicantID = @ApplicantID 
			and EventID = @EventID 
			and SubEventID = @SubEventID
	)
	begin

		insert into ProjectEvent(Prog, ProjectID, ApplicantID, EventID, SubEventID, Date, Note, UserID)
		values(@Prog, @ProjectID, @ApplicantID, @EventID, @SubEventID, @Date, @Note, @UserID)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from ProjectEvent(nolock)
		where Prog = @Prog 
			and ProjectID = @ProjectID 
			and ApplicantID = @ApplicantID 
			and EventID = @EventID 
			and SubEventID = @SubEventID
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateProjectEvent]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateProjectEvent
go

create procedure dbo.UpdateProjectEvent
(
	@ProjectEventID	int,
	@Prog			int, 
	@ProjectID		int, 
	@ApplicantID	int, 
	@EventID		int, 
	@SubEventID		int, 
	@Date			datetime, 
	@Note			nvarchar(max), 
	@UserID			int,
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	declare @AppNameID int
	set @AppNameID = @ApplicantID
	set @ApplicantID = 0
	select @ApplicantID = ApplicantID from ApplicantAppName(nolock) where AppNameID = @AppNameID

	update ProjectEvent set ApplicantID = @ApplicantID, EventID= @EventID, SubEventID = @SubEventID, Date = @Date, Note = @Note, UserID = @UserID,
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from ProjectEvent
	where ProjectEventID = @ProjectEventID
	
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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetProjectEventById]') and type in (N'P', N'PC'))
drop procedure [dbo].GetProjectEventById
go

create procedure GetProjectEventById
(
	@ProjectEventID int
)  
as
--exec GetProjectEventById 6588
begin

	select ProjectEventID, Prog, ProjectID, ApplicantID, EventID, SubEventID, Date, Note, UserID, RowIsActive
	from ProjectEvent (nolock)
	where ProjectEventID = @ProjectEventID
end
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetEventListByEntity]') and type in (N'P', N'PC'))
drop procedure [dbo].GetEventListByEntity
go

create procedure GetEventListByEntity  
(
	@ApplicantID		int,
	@IsActiveOnly		bit
)
as
begin
--exec GetEventListByEntity 424, 1
	select pe.ProjectEventID, 
		pe.Prog, lv.Description as Program, 
		pe.ProjectID, p.project_name, 
		pe.ApplicantID, an.applicantname, 
		pe.EventID, lv1.Description as Event, 
		pe.SubEventID, lv2.Description as SubEvent,
		pe.Date,
		substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes,
		pe.UserID, ui.username, 
		pe.RowIsActive
	from ProjectEvent pe(nolock)
	left join project_v p(nolock) on pe.ProjectID = p.project_id and p.defname = 1
	left join applicantappname aan(nolock) on pe.ApplicantId = aan.ApplicantID
	left join appname an(nolock) on aan.appnameid = an.appnameid
	left join applicant a(nolock) on a.applicantid = aan.applicantid
	left join LookupValues lv(nolock) on lv.TypeID = pe.Prog
	left join LookupValues lv1(nolock) on lv1.TypeID = pe.EventID
	left join LookupValues lv2(nolock) on lv2.TypeID = pe.SubEventID
	left join userinfo ui(nolock) on ui.userid = pe.UserId
	where isnull(pe.ApplicantID, 0) = @ApplicantID and @ApplicantID != 0 
		and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
	order by pe.DateModified desc
end
go