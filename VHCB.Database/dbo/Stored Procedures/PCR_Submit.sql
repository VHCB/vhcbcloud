CREATE procedure [dbo].[PCR_Submit]
(
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
	@CRDate date,
	@ProjectCheckReqID	int output,
	@TransID	int output
)
as
Begin
begin transaction

	begin try

	insert into ProjectCheckReq(ProjectID, InitDate, LkProgram, LegalReview, 
		LCB, MatchAmt, LkFVGrantMatch, Notes, UserID, crdate, CreatedBy)
	values(@ProjectID, @InitDate, @LkProgram, @LegalReview, 
		@LCB, @MatchAmt, @LkFVGrantMatch, @Notes, @UserID, @CRDate, @UserID)

	set @ProjectCheckReqID = @@IDENTITY

	insert into Trans(ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus, UserID)
	values(@ProjectID, @ProjectCheckReqID, @InitDate, @Disbursement, @Payee, 236, @LkStatus, @UserID)

	set @TransID = @@IDENTITY

	--exec PCR_Submit_NOD @ProjectCheckReqID, @LKNODs

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