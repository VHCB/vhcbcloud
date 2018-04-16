CREATE procedure PCR_Update_CheckReqDate
(
	@ProjectCheckReqID int,
	@CrDate date
)
as
begin
	begin transaction

	begin try

		update ProjectCheckReq set CRDate = @crDate
		from ProjectCheckReq
		where ProjectCheckReqID = @ProjectCheckReqID

		update Trans set Date = @CrDate
		where ProjectCheckReqID = @ProjectCheckReqID

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