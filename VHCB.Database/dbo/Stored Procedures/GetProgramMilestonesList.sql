CREATE procedure dbo.GetProgramMilestonesList  
(
	@ProjectID		int,
	@IsAll			bit,
	@IsAdmin		bit,
	@IsProgram		bit,
	@IsActiveOnly	bit
)
as
begin
--exec GetProgramMilestonesList 4656, 1, 0, 0, 1 --ALL
--exec GetProgramMilestonesList 0, 1, 0, 1 -- Admin
--exec GetProgramMilestonesList 0, 0, 1, 1 -- Program

	if(@IsAll = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lsv1.SubDescription as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
			CASE when isnull(pe.URL, '') = '' then '' else 'Click here' end as URLText,
			pe.UserID, ui.username, 
			pe.RowIsActive
		from ProjectEvent pe(nolock)
		left join project_v p(nolock) on pe.ProjectID = p.project_id and p.defname = 1
		left join applicantappname aan(nolock) on pe.ApplicantId = aan.ApplicantID
		left join appname an(nolock) on aan.appnameid = an.appnameid
		left join applicant a(nolock) on a.applicantid = aan.applicantid
		left join LookupValues lv(nolock) on lv.TypeID = pe.Prog
		left join LookupValues lv1(nolock) on lv1.TypeID = pe.EventID
		--left join LookupValues lv2(nolock) on lv2.TypeID = pe.SubEventID
		left join LookupSubValues lsv1(nolock) on lsv1.SubTypeID = pe.SubEventID
		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.SubTypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where ProjectID = @ProjectID 
			and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
		order by pe.DateModified desc
	end

	if(@IsAdmin = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lsv1.SubDescription as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
			CASE when isnull(pe.URL, '') = '' then '' else 'Click here' end as URLText,
			pe.UserID, ui.username, 
			pe.RowIsActive
		from ProjectEvent pe(nolock)
		left join project_v p(nolock) on pe.ProjectID = p.project_id and p.defname = 1
		left join applicantappname aan(nolock) on pe.ApplicantId = aan.ApplicantID
		left join appname an(nolock) on aan.appnameid = an.appnameid
		left join applicant a(nolock) on a.applicantid = aan.applicantid
		left join LookupValues lv(nolock) on lv.TypeID = pe.Prog
		left join LookupValues lv1(nolock) on lv1.TypeID = pe.EventID
		--left join LookupValues lv2(nolock) on lv2.TypeID = pe.SubEventID
		left join LookupSubValues lsv1(nolock) on lsv1.SubTypeID = pe.SubEventID
		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.SubTypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where ProjectID = @ProjectID and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
			and ((pe.EventID is not null and pe.EventID != 0) or (pe.SubEventID is not null and pe.SubEventID != 0 ))
		order by pe.DateModified desc
	end

	if(@IsProgram = 1)
	begin
		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.EventID, lv1.Description as Event, 
			pe.SubEventID, lsv1.SubDescription as SubEvent,
			pe.ProgEventID, lv3.Description as ProgEvent,
			pe.ProgSubEventID, lsv.SubDescription as ProgSubEvent,
			pe.EntityMSID, 
			pe.EntitySubMSID,
			pe.Date,
			substring(pe.Note, 0, 25) Notes, pe.Note as FullNotes, pe.URL,
			CASE when isnull(pe.URL, '') = '' then '' else 'Click here' end as URLText,
			pe.UserID, ui.username, 
			pe.RowIsActive
		from ProjectEvent pe(nolock)
		left join project_v p(nolock) on pe.ProjectID = p.project_id and p.defname = 1
		left join applicantappname aan(nolock) on pe.ApplicantId = aan.ApplicantID
		left join appname an(nolock) on aan.appnameid = an.appnameid
		left join applicant a(nolock) on a.applicantid = aan.applicantid
		left join LookupValues lv(nolock) on lv.TypeID = pe.Prog
		left join LookupValues lv1(nolock) on lv1.TypeID = pe.EventID
		--left join LookupValues lv2(nolock) on lv2.TypeID = pe.SubEventID

		left join LookupSubValues lsv1(nolock) on lsv1.SubTypeID = pe.SubEventID

		left join LookupValues lv3(nolock) on lv3.TypeID = pe.ProgEventID
		left join LookupSubValues lsv(nolock) on lsv.SubTypeID = pe.ProgSubEventID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where ProjectID = @ProjectID and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
			and ((pe.ProgEventID is not null and pe.ProgEventID != 0) or (pe.ProgSubEventID is not null and pe.ProgSubEventID != 0))
		order by pe.DateModified desc
	end
end