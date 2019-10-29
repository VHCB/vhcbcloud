
create procedure dbo.UpdateApplicantApplicant
(
	@ApplicantApplicantId	int,
	@RowIsActive			bit
) as
begin transaction

	begin try
	
	update ApplicantApplicant set  RowIsActive = @RowIsActive, DateModified = getdate()
	from ApplicantApplicant 
	where ApplicantApplicantId = @ApplicantApplicantId

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