CREATE procedure dbo.AddProjectFederalProgramDetail
(
	@ProjectFederalId	int, 
	@Recert				int, 
	@LKAffrdPer			int, 
	@AffrdPeriod		int,
	@AffrdStart			DateTime, 
	@AffrdEnd			DateTime, 
	@CHDO				bit, 
	@CHDORecert			int, 
	@IsUARegulation		bit,
	@freq				int, 
	@IDISNum			nvarchar(4), 
	@Setup				DateTime, 
	@CompleteBy			int, 
	@FundedDate			DateTime, 
	@FundCompleteBy		int,
	@IDISClose			DateTime,
	@IDISCompleteBy		int
) as
begin transaction

	begin try

	insert into ProjectFederalProgramDetail(ProjectFederalId, Recert, LKAffrdPer, AffrdPeriod, AffrdStart, AffrdEnd, CHDO, CHDORecert, 
		freq, IDISNum, Setup, CompleteBy, FundedDate, FundCompleteBy, IDISClose, IDISCompleteBy, IsUARegulation)
	values(@ProjectFederalId, @Recert, @LKAffrdPer, @AffrdPeriod, @AffrdStart, @AffrdEnd, @CHDO, @CHDORecert, 
		@freq, @IDISNum, @Setup, @CompleteBy, @FundedDate, @FundCompleteBy, @IDISClose, @IDISCompleteBy, @IsUARegulation)

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