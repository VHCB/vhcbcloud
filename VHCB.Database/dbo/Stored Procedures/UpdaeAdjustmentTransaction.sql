CREATE procedure dbo.UpdaeAdjustmentTransaction
(
	@TransId	int,
	@DetailId int,
	@projId			int,
	@TransAmt		decimal,
	@FundId			int,
    @FundTtransType int,
	@Comment		nvarchar(200),
    @UserID			int,
	@LkTransaction	int,
	@LandUsePermitId	int = null
)
as
Begin
	
	update Trans set ProjectID = @projId, TransAmt = @TransAmt, ReallAssignAmt = @TransAmt, UserID = @UserID, Comment = @Comment, LkTransaction = @LkTransaction
	where TransId = @TransId

	update Detail set FundId = @FundId, LkTransType = @FundTtransType, ProjectID = @projId, Amount=  @TransAmt, LandUsePermitID = @LandUsePermitId
	where DetailId = @DetailId

End