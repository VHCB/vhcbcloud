
CREATE procedure DeleteProjectFund
(	
	@transid int	
)
as
BEGIN TRANSACTION

BEGIN TRY
	
	Delete from detail where transid = @transid
	
	Delete from trans where transid = @transid
			
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