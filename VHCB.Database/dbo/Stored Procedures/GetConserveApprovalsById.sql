
create procedure dbo.GetConserveApprovalsById
(
	@ConserveApprovalID	int
) as
begin transaction
-- GetConserveApprovalsById 2
	begin try
	
	select ConserveApprovalID, ConserveID, LKApproval, ReqDate, LKDisp, DispDate, Comments, URL, RowIsActive, DateModified
	from ConserveApproval
	where ConserveApprovalID = @ConserveApprovalID

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