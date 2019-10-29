CREATE procedure dbo.AddProjectApplicant
(
	@ProjectId			int,
	@ApplicantID		int,
	@LkApplicantRole	int,
	@IsApplicant		bit
	--@Defapp				bit, 
	--@FinLegal			bit	
) as
begin transaction

	begin try

	--declare @ApplicantId int

	--select @ApplicantId = ApplicantID from ApplicantAppName(nolock) where AppNameID = @AppNameId

	insert into ProjectApplicant(ProjectId, ApplicantId,  LkApplicantRole, IsApplicant, UserID)--, Defapp, FinLegal,
	values(@ProjectId, @ApplicantId,  @LkApplicantRole, @IsApplicant, 123)-- 358 @LkApplicantRole, @Defapp, @IsApplicant, @FinLegal,

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