CREATE procedure PCR_Update
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
	@Disbursement decimal(8,2),
	@Payee int,
	@LkStatus int,
	@UserID	int,
	@LKNODs 	varchar(50),
	@CrDate date,
	@TransID	int output
)
as
begin
	begin transaction

	begin try
		declare @Balanced bit

		update ProjectCheckReq set ProjectID = @ProjectID, InitDate = @InitDate, LkProgram = @LkProgram, LegalReview = @LegalReview, 
			LCB =  @LCB, MatchAmt = @MatchAmt, LkFVGrantMatch = @LkFVGrantMatch, Notes = @Notes, UserID = @UserID, CRDate = @crDate
		from ProjectCheckReq
		where ProjectCheckReqID = @ProjectCheckReqID

		select @TransID = TransID from Trans where ProjectCheckReqID = @ProjectCheckReqID

		--declare @TransAmount decimal
		declare @DetailsAmount decimal

		--select @TransAmount = isnull(TransAmt, 0) from Trans(nolock) where TransId = @TransId
		select @DetailsAmount = sum(isnull(Amount, 0)) from Detail (nolock) where TransId = @TransId and RowIsActive = 1

		if(@Disbursement = -@DetailsAmount)
		set @Balanced = 1
		else
		set @Balanced = 0

		update Trans set ProjectID = ProjectID, Date = @CrDate, --@InitDate, 
		TransAmt = @Disbursement, PayeeApplicant = @Payee, LkTransaction = 236, LkStatus = @LkStatus,
		Balanced = @Balanced
		from Trans
		where TransID = @TransID

		delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID


		select pcr.ProjectCheckReqId, CONVERT(VARCHAR(101),pcr.InitDate,110)  +' - ' +convert(varchar(20), t.TransAmt)+' - '+ lv.Description as pcq, @TransID as transid
		from ProjectCheckReq pcr(nolock)
		join Trans t(nolock) on t.ProjectCheckReqId = pcr.ProjectCheckReqId
		join project_v pv(nolock) on pcr.ProjectID = pv.Project_id
		join applicant a(nolock) on a.ApplicantId = t.PayeeApplicant
		join ApplicantAppName aan(nolock) on a.applicantid = aan.applicantid
		join AppName an(nolock) on aan.AppNameID = an.AppNameID
		join LookupValues lv on lv.TypeID = t.LkStatus
	where pcr.ProjectCheckReqID = @ProjectCheckReqID
	order by pcr.ProjectCheckReqId desc
		
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
end