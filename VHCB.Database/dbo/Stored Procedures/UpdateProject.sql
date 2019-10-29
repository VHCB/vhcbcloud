
create procedure dbo.UpdateProject
(
	@ProjectId			int,
	@LkProjectType		int,
	@LkProgram			int,
	@AppRec				Datetime,
	@LkAppStatus		int,
	@Manager			int,
	@LkBoardDate		int,
	@ClosingDate		datetime,
	@GrantClosingDate	datetime,
	@verified			bit,

	@appNameId			int
	--@projName			varchar(75)
) as
begin transaction

	begin try

	declare @applicantId int

	update Project set LkProjectType = @LkProjectType, LkProgram = @LkProgram, AppRec = @AppRec, LkAppStatus = @LkAppStatus,
		Manager = @Manager, LkBoardDate = @LkBoardDate, ClosingDate = @ClosingDate, ExpireDate = @GrantClosingDate, verified = @verified
	from Project
	where ProjectId = @ProjectId

	Select @applicantId = a.ApplicantId 
	from AppName an(nolock)
	join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
	join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
	where an.AppNameID = @appNameId

	update pa set ApplicantId = @applicantId
	from ProjectApplicant pa
	where projectId = @projectId

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