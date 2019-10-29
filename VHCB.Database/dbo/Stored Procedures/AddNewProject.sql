CREATE procedure [dbo].[AddNewProject]
(
	@projName	varchar(75),
	@projNum	varchar(12),
	@appNameId	int,
	@isDuplicate	bit output
)
as 
begin
	BEGIN TRANSACTION

	BEGIN TRY

	set @isDuplicate = 1

	 if not exists
        (
			select 1
			from project
			where proj_num = @projnum
        )
		begin

			Declare @nameId as int;
			Declare @projectId as int;
			declare @recordId int
			declare @applicantId int
			select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
			Select @applicantId = a.ApplicantId from AppName an
			join ApplicantAppName aan on aan.appnameid = an.appnameid
			join Applicant a on a.ApplicantId = aan.ApplicantID
			where an.AppNameID = @appNameId

			insert into LookupValues(LookupType, description)
			values (@recordId, @projName)
	
			set @nameId = @@IDENTITY

			insert into Project (Proj_num)
			values (@projNum)
	
			set @projectId = @@IDENTITY

			insert into ProjectName (ProjectID, LkProjectname,DefName)
			values (@projectId, @nameId,1)

			insert into ProjectApplicant (ProjectId, ApplicantId, LkApplicantRole)
			values (@projectId, @applicantId, 358)

			set @isDuplicate = 0
		end
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() +' - ' +ERROR_MESSAGE() AS ErrNumMsg,        
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() as ErrorState,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_LINE() as ErrorLine;
        
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;
end