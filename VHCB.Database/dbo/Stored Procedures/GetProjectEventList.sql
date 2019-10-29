
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