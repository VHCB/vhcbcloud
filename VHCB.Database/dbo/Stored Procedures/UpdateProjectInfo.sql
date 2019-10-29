CREATE procedure [dbo].[UpdateProjectInfo]
(
	@ProjectId			int,
	@LkProjectType		int,
	@LkProgram			int,
	@Manager			int,
	--@ClosingDate		datetime,
	@verified			bit = false,
	@appName			varchar(150),
	@goal				int
	--@projName			varchar(75)
) as
begin transaction

	begin try

	declare @applicantId int
	declare @CurrentApplicantId int

	update Project set LkProjectType = @LkProjectType, LkProgram = @LkProgram,
		Manager = @Manager, Goal = @goal, verified = @verified, verifieddate = getdate() --ClosingDate = @ClosingDate
	from Project
	where ProjectId = @ProjectId

	Select @applicantId = a.ApplicantId 
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	where an.Applicantname = @appName

	--Select @applicantId = a.ApplicantId 
	--from AppName an(nolock)
	--join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	--join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	--where an.AppNameID = @appNameId

	select @CurrentApplicantId = pa.ApplicantId
	from ProjectApplicant pa
	where projectId = @projectId and pa.LkApplicantRole = 358

	if(isnull(@CurrentApplicantId, '') != @applicantId)
	begin
		--Update Current Primary Applicant
		update pa set LkApplicantRole = '', IsApplicant = 0, FinLegal = 0, DateModified = getdate()
		from ProjectApplicant pa
		where projectId = @projectId and pa.LkApplicantRole = 358

		--Delete If the Entity/Applicant already assigned some time back.
		delete from ProjectApplicant 
		where ProjectId = @ProjectId and ApplicantId = @applicantId

		--Insert New Primary Applicant
		insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant, FinLegal)
		values (@ProjectId, @applicantId, 358, 1, 1)
	end

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