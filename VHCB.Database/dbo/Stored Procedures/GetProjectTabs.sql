
create procedure dbo.GetProjectTabs
(
	@LKProgramID	int
)
as
begin transaction
--exec GetProjectTabs 145
	begin try

		select TabText, TabURL from LKProgramID(nolock) where LKProgramID = @LKProgramID

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