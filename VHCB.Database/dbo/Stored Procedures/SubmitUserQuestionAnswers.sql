
create procedure dbo.SubmitUserQuestionAnswers
(
	@UserId int,
	@YrQrtrId int
)
as
begin transaction

	begin try
	
	  Update acperfdata
	  Set IsCompleted = 1
	  where UserID = @UserId and ACPerformanceMasterID in (Select ACPerformanceMasterID From [ACPerformanceMaster] where ACYrQtrID = @YrQrtrId )

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