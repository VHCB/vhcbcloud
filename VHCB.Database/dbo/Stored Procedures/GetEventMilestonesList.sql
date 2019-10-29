CREATE procedure dbo.GetEventMilestonesList  
(
	@AppName		nvarchar(100),
	@IsActiveOnly	bit
)
as
begin
--exec GetEventMilestonesList 'Barker, Stephen & Kathleen', 1

	declare @applicantId int

	Select @applicantId = a.ApplicantId 
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.Applicantname = @AppName

		select pe.ProjectEventID, 
			pe.Prog, lv.Description as Program, 
			pe.ProjectID, p.project_name, 
			pe.ApplicantID, an.applicantname, 
			pe.ProgSubEventID, 
			pe.EntityMSID, lv.Description as EntityMilestone,
			pe.EntitySubMSID, lsv.SubDescription as EntitySubMilestone,
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
		left join LookupValues lv(nolock) on lv.TypeID = pe.EntityMSID
		left join LookupSubValues lsv(nolock) on lsv.SubTypeID = pe.EntitySubMSID
		left join userinfo ui(nolock) on ui.userid = pe.UserId
		where pe.ApplicantID = @ApplicantID and (@IsActiveOnly = 0 or pe.RowIsActive = @IsActiveOnly)
			and (pe.EntityMSID is not null and pe.EntityMSID != 0)
		order by pe.DateModified desc
end