CREATE procedure dbo.GetApplicantId
(
	@appName		varchar(200),
	@ApplicantId	int output
) as
begin transaction
--GetApplicantId 'AAA', null
	begin try

	set @ApplicantId = 0;
	Select @ApplicantId = isnull(a.ApplicantId, 0)
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.Applicantname = @appName

	

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