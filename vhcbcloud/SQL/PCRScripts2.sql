use vhcbsandbox
go

create procedure PCR_Trans_Status
as
begin
	select typeid, Description 
	from [dbo].[Lkstatus_v] 
	where LookupType = 124
	order by typeid
end
go

create procedure GetPCRData
as
begin
	select pcr.ProjectCheckReqId, t.transid, pcr.ProjectID, pv.project_name, pcr.InitDate, pcr.LegalReview, t.TransAmt, an.Applicantname as Payee
	from ProjectCheckReq pcr(nolock)
	join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
	join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
	join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
	join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
	join AppName an(nolock) on aan.AppNameID = an.AppNameID
	order by pcr.ProjectCheckReqId desc

end
go

--exec GetPCRDetails 25

create procedure GetPCRDetails
(
	@ProjectCheckReqId int
)
as
begin
	select ProjectID, InitDate, LkProgram, LegalReview, 
			Final, LCB, MatchAmt, LkFVGrantMatch, Notes, UserID 
	from ProjectCheckReq pcr(nolock)
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

end
go

--exec GetNODDataByPCRID 66
create procedure GetNODDataByPCRID
(
	@ProjectCheckReqId int
)
as
begin
	select LKNOD from ProjectCheckReqNOD(nolock) where ProjectCheckReqID = @ProjectCheckReqID
end
go

--exec GetQuestionsByPCRID 66
create procedure GetQuestionsByPCRID
(
	@ProjectCheckReqId int
)
as
begin
	select ProjectCheckReqID, LkPCRQuestionsID, Approved, Date, StaffID from ProjectCheckReqQuestions(nolock)  where ProjectCheckReqID = @ProjectCheckReqID
end
go

create procedure PCR_Update
(
	@ProjectCheckReqID int,
	@ProjectID int, 
	@InitDate date, 
	@LkProgram	int, 
	@LegalReview	bit, 
	@LCB	bit, 
	@MatchAmt	money, 
	@LkFVGrantMatch	int, 
	@Notes	nvarchar(2000), 
	@Disbursement decimal,
	@Payee int,
	@LkStatus int,
	@UserID	int,
	@TransID	int output
)
as
begin

	update ProjectCheckReq set ProjectID = @ProjectID, InitDate = @InitDate, LkProgram = @LkProgram, LegalReview = @LegalReview, 
		LCB =  @LCB, MatchAmt = @MatchAmt, LkFVGrantMatch = @LkFVGrantMatch, Notes = @Notes, UserID = @UserID
	from ProjectCheckReq
	where ProjectCheckReqID = @ProjectCheckReqID

	select @TransID = TransID from Trans where ProjectCheckReqID = @ProjectCheckReqID

	update Trans set ProjectID = ProjectID, Date = @InitDate, TransAmt = @Disbursement, PayeeApplicant = @Payee, LkTransaction = 236, LkStatus = @LkStatus
	from Trans
	where TransID = @TransID

end
go