CREATE procedure dbo.SubmitAdjustmentTransaction
(
	@projId			int,
	@TransAmt		money,
	@FundId			int,
    @FundTtransType int,
	@Comment		nvarchar(200),
    @UserID			int,
	@LkTransaction	int,
	@LandUsePermitId	int = null,
	@TransId		int output,
	@DetailId		int output
)
as
Begin
	

	insert into Trans(ProjectID, Date, TransAmt, LkTransaction, LkStatus, ReallAssignAmt, UserID, Comment, Adjust)
	values(@projId, GETDATE(), @TransAmt, @LkTransaction, 261, @TransAmt, @UserID, @Comment, 1) --26733

	set @TransId = @@identity

	insert into Detail(TransId, FundId, LkTransType, ProjectID, Amount, LandUsePermitID)
	values(@TransId, @FundId, @FundTtransType, @projId, @TransAmt, @LandUsePermitId)

	set @DetailId = @@identity
End