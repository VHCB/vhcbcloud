CREATE procedure SubmitVoidTransaction
(
	@TransId int,
	@UserId int
)
as
begin
	begin transaction

	begin try

	declare @newTransId int
	declare @ProjectCheckReqID int

	select @ProjectCheckReqID = ProjectCheckReqID
	from Trans t(nolock) 
	where t.TransId = @TransId

	insert into Trans(ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, LkTransaction, LkStatus, Balanced, UserID)
	select ProjectID, ProjectCheckReqID, Date, TransAmt, PayeeApplicant, 237, 261, Balanced, @UserId
	from Trans t(nolock) 
	where t.TransId = @TransId

	set @newTransId = @@IDENTITY

	insert into Detail(TransId, FundId, LkTransType, ProjectID, Amount, LandUsePermitID, DetailGuId)
	select @newTransId, FundId, LkTransType, ProjectID, -Amount, LandUsePermitID, DetailGuId
	from Detail where TransId = @TransId

	update ProjectCheckReq set Voided = 1 where ProjectCheckReqID = @ProjectCheckReqID

	--select * from Trans where TransId = @newTransId
	--select * from Detail where TransId = @newTransId

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