
create procedure dbo.UpdateProjectApplicant
(
	@ProjectApplicantId	int,
	@IsApplicant		bit, 
	@IsFinLegal			bit,
	@LkApplicantRole	int,
	@IsRowIsActive		bit
) as
begin transaction

	begin try

	update ProjectApplicant set IsApplicant = @IsApplicant, FinLegal = @IsFinLegal, 
		LkApplicantRole = @LkApplicantRole, RowIsActive = @IsRowIsActive, DateModified = getdate()
	where ProjectApplicantId = @ProjectApplicantId
	
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