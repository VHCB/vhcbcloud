
create procedure dbo.GetTotalFederalProgramUnits
(
	@ProjectId int
) as
begin transaction
--exec GetTotalFederalProgramUnits 6588
	begin try

	Select isnull(sum(NumUnits), 0)
	from ProjectFederal(nolock) 
	where ProjectId = @ProjectId

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