CREATE procedure dbo.GetProjectFederalProgramDetailById
(
	@ProjectFederalId	int
) as
begin transaction

	begin try

	select ProjectFederalProgramDetailID, ProjectFederalId, Recert, LKAffrdPer, AffrdPeriod, AffrdStart, AffrdEnd, CHDO, CHDORecert, 
		freq, IDISNum, Setup, CompleteBy, FundedDate, FundCompleteBy, IDISClose, IDISCompleteBy, IsUARegulation
	from ProjectFederalProgramDetail(nolock)
	where ProjectFederalId = @ProjectFederalId
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