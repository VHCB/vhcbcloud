CREATE procedure GetPCRDetails
(
	@ProjectCheckReqId int
)
as
begin
	select ProjectID, InitDate, LkProgram, LegalReview, convert(varchar(10), crdate) crdate,
			Final, LCB, MatchAmt, LkFVGrantMatch, Notes, pcr.UserID, uinfo.username as CreatedBy
	from ProjectCheckReq pcr(nolock)
	left join userinfo uinfo(nolock) on uinfo.UserId = pcr.CreatedBy
	where ProjectCheckReqId = @ProjectCheckReqId

	declare @TransId int

	select @TransId = TransId from Trans(nolock) where ProjectCheckReqId = @ProjectCheckReqId

	select TransId, ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus
	from trans t(nolock)
	where ProjectCheckReqId = @ProjectCheckReqId

	select TransId, FundId, LkTransType, Amount
	from Detail (nolock)
	where TransId = @TransId

	exec PCR_Trans_Detail_Load @TransId
	
	select LKNOD from ProjectCheckReqNOD(nolock) where ProjectCheckReqID = @ProjectCheckReqID

	select ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID from ProjectCheckReqQuestions(nolock)  where ProjectCheckReqID = @ProjectCheckReqID

	select pa.applicantid from project p join projectapplicant pa on pa.ProjectId = p.ProjectId
		join projectcheckreq pcr on pcr.ProjectID = p.ProjectId where pa.FinLegal = 1 and pcr.ProjectCheckReqID = @ProjectCheckReqID
	
	Select LKCRItems from ProjectCheckReqItems where ProjectCheckReqID = @ProjectCheckReqID
end