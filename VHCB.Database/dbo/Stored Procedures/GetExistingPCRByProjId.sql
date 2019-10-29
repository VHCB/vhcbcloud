
CREATE procedure [dbo].[GetExistingPCRByProjId]
(
	@projId int
)
as
Begin
	
	declare @payee varchar (100)
	set @payee = (select top 1 an.applicantname
		from ProjectApplicant pa(nolock)
		join applicantappname aan(nolock) on pa.ApplicantId = aan.ApplicantID
		join appname an(nolock) on aan.appnameid = an.appnameid
		join applicant a(nolock) on a.applicantid = aan.applicantid
		left join applicantcontact ac(nolock) on a.ApplicantID = ac.ApplicantID
		left join contact c(nolock) on c.ContactID = ac.ContactID
		left join LookupValues lv(nolock) on lv.TypeID = pa.LkApplicantRole
		where pa.ProjectId = @projId
			and pa.RowIsActive = 1 and pa.finlegal = 1
		order by pa.IsApplicant desc, pa.FinLegal desc, pa.DateModified desc)

	select pcr.ProjectID, pv.project_name, pcr.legalreview,pcr.LCB, pcr.initdate, pcr.ProjectCheckReqId, convert(varchar(10),  pcr.crdate) crdate,
	t.TransAmt, t.transid, an.Applicantname, @payee as Payee,
	CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq, 
	uinfo.username as CreatedBy, pcr.CreatedBy as CreatedById, AllApproved
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	join LookupValues lv on lv.TypeID = t.LkStatus
	left join userinfo uinfo(nolock) on uinfo.UserId = pcr.CreatedBy
	where pv.defname = 1 and pcr.projectid = @projId and t.LkStatus = 261 and t.LkTransaction = 236
	order by pcr.ProjectCheckReqId desc

	
End