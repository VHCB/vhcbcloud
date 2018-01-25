
CREATE procedure [dbo].[AddNewCheckRequest]
(
	@projId int,
	@appnameid int,
	@dtVoucherDate date
)
as 
BEGIN TRANSACTION

BEGIN TRY
	
	declare @applicantId int
	
	Select @applicantId = a.ApplicantId from AppName an
	join ApplicantAppName aan on aan.appnameid = an.appnameid
	join Applicant a on a.ApplicantId = aan.ApplicantID
	where an.AppNameID = @appNameId

	insert into ProjectCheckReq (InitDate,ProjectID)
	values (@dtVoucherDate,@projId)	

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