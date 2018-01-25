CREATE procedure GetExistingPCR
as
Begin
	select pcr.ProjectID, pcr.ProjectCheckReqId, 
	CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	join LookupValues lv on lv.TypeID = t.LkStatus
	where pv.defname = 1
	order by pcr.ProjectCheckReqId desc
End