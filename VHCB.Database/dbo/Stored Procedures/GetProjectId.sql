CREATE procedure dbo.GetProjectId
(
	@ProjectNum		nvarchar(20),
	@ProjectId		int output 
) as
begin transaction
-- exec GetProjectId '2001-001-001', ''
	begin try

	declare @ProjNum1 varchar(50)
	select @ProjNum1 = dbo.GetHyphenProjectNumber(@ProjectNum);

	select @ProjectId = ProjectId from Project where proj_num = @ProjNum1
		

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