CREATE procedure dbo.UpdateProjectFederalProgramDetail
(
	@ProjectFederalProgramDetailID	int,
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

	update ProjectFederalProgramDetail set Recert = @Recert, LKAffrdPer = @LKAffrdPer, AffrdPeriod = @AffrdPeriod, AffrdStart = @AffrdStart, 
		AffrdEnd = @AffrdEnd, CHDO = @CHDO, CHDORecert = @CHDORecert, 
		freq = @freq, IDISNum = @IDISNum, Setup = @Setup, CompleteBy = @CompleteBy, FundedDate = @FundedDate, FundCompleteBy = @FundCompleteBy,
		IDISClose = @IDISClose, IDISCompleteBy = @IDISCompleteBy, IsUARegulation= @IsUARegulation, DateModified = getdate()
	from ProjectFederalProgramDetail
	where ProjectFederalProgramDetailID = @ProjectFederalProgramDetailID
	
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