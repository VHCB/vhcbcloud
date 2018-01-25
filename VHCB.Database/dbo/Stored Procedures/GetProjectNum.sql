
create procedure dbo.GetProjectNum
(
	@ProjectId			int
) as
begin transaction
-- exec GetProjectNum 4834
	begin try

	select proj_num from Project where ProjectId = @ProjectId
		

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