
create procedure GetPCRDataById
(
	@ProjectCheckReqID	int
)
as
begin
	select pcr.ProjectCheckReqId, t.transid, pcr.ProjectID, pv.project_name, pcr.InitDate, pcr.LegalReview, t.TransAmt, an.Applicantname as Payee
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	where pcr.ProjectCheckReqId = @ProjectCheckReqID
	order by pcr.ProjectCheckReqId desc

end