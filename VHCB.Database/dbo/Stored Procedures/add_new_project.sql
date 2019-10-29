CREATE procedure dbo.add_new_project
(
	@projNum			nvarchar(12),
	@LkProjectType		int,
	@LkProgram			int,
	@Manager			int,
	--@verified			bit,
	@appName			varchar(150),
	@projName			varchar(75),
	@goal				int,
	@IsTBDAddress		bit,
	@isDuplicate		bit output,
	@ProjectId			int output
) as
begin transaction

	begin try

	set @isDuplicate = 1

	 if not exists
        (
			select 1
			from project
			where proj_num = @projnum
        )
		begin

			Declare @nameId as int;
			--Declare @projectId as int;
			declare @recordId int
			declare @applicantId int

			select  @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
			insert into LookupValues(LookupType, Description)
			values (@recordId, @projName)

			set @nameId = @@IDENTITY

			insert into Project (Proj_num, LkProjectType, LkProgram, Manager, userid, Goal)
			values (@projNum, @LkProjectType, @LkProgram, @Manager, 123, @Goal)
	
			set @ProjectId = @@IDENTITY

			insert into ProjectName (ProjectID, LkProjectname, DefName)
			values (@ProjectId, @nameId, 1)


			Select @applicantId = a.ApplicantId 
			from AppName an(nolock)
			join ApplicantAppName aan(nolock) on aan.appnameid = an.appnameid
			join Applicant a(nolock) on a.ApplicantId = aan.ApplicantID
			where an.Applicantname = @appName

			insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole, IsApplicant)
			values (@ProjectId, @applicantId, 358, 1)

			if(@IsTBDAddress = 1)
			begin
				insert into ProjectAddress(ProjectId, AddressId, PrimaryAdd)
				values(@ProjectId, 171, 1)
			end

			set @isDuplicate = 0
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