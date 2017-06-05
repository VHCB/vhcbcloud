use vhcbsandbox
go

create procedure dbo.AddMilestone
(
	@Prog			int, 
	@ProjectID		int, 
	@AppName		varchar(50), 

	@EventID		int, --Admin Milestone ID
	@SubEventID		int, 

	@ProgEventID	int, --Program Milestone ID
	@ProgSubEventID	int,

	@EntityMSID		int, --Entity MileStone ID
	@EntitySubMSID	int,

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
	
	declare @applicantId int

	Select @applicantId = a.ApplicantId 
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.Applicantname = @AppName


	if not exists
    (
		select 1 
		from ProjectEvent(nolock)
		where Prog = @Prog 
			and ProjectID = @ProjectID 
			and ApplicantID = @ApplicantID and ApplicantID != 0  
			and EventID = @EventID  and EventID != 0 
			and SubEventID = @SubEventID and SubEventID != 0
	)
	begin
		insert into ProjectEvent(Prog, ProjectID, ApplicantID, EventID, SubEventID, 
			ProgEventID, ProgSubEventID, EntityMSID, EntitySubMSID, 
			Date, Note, UserID)
		values(@Prog, @ProjectID, @ApplicantID, @EventID, @SubEventID, 
			@ProgEventID, @ProgSubEventID, @EntityMSID, @EntitySubMSID, 
			@Date, @Note, @UserID)

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

alter procedure dbo.GetMilestonesList  
(
	--@ProjectID		int,
	@IsAll			bit,
	@IsAdmin		bit,
	@IsProgram		bit,
	@IsActiveOnly	bit
)
as
begin
--exec GetMilestonesList 1, 0, 0, 1 --ALL
--exec GetMilestonesList 0, 1, 0, 1 -- Admin
--exec GetMilestonesList 0, 0, 1, 1 -- Program

	if(@IsAll = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lv2.Description as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
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
		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.TypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
		order by pe.DateModified desc
	end

	if(@IsAdmin = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lv2.Description as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
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
		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.TypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
			and (pe.EventID is not null and pe.EventID != 0)
		order by pe.DateModified desc
	end

	if(@IsProgram = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lv2.Description as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
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
		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.TypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
			and (pe.ProgEventID is not null and pe.ProgEventID != 0)
		order by pe.DateModified desc
	end
end
go
