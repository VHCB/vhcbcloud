
CREATE procedure [dbo].[UpdateCheckRequest]
(
	@projectApplicantID int,
	@transAmt money,
	@dtVoucherDate date
)
as 
BEGIN TRANSACTION

BEGIN TRY
	declare @applicantId int 
	declare @projectId int
	select @applicantId = ApplicantId, @projectId = ProjectId from ProjectApplicant where ProjectApplicantID = @projectApplicantID
	
	update ProjectCheckReq set initdate = @dtVoucherDate where ProjectID = @projectId

	
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
        
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;