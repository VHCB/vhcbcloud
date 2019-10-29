CREATE procedure PCR_Delete
(
	@ProjectCheckReqID int
	
)
as
begin
	begin transaction

	begin try
		declare @transId int
				
		select @transId = transid from trans where ProjectCheckReqID = @ProjectCheckReqID
		delete from detail where transid = @transId
		delete from trans where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqNOD where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReqQuestions where ProjectCheckReqID = @ProjectCheckReqID
		delete from ProjectCheckReq where ProjectCheckReqID = @ProjectCheckReqID
		
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