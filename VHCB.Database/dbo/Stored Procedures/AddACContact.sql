/****** Object:  StoredProcedure [dbo].[AddACContact]    Script Date: 6/3/2015 11:31:35 PM ******/



CREATE procedure [dbo].[AddACContact]
(	
	@fName varchar(20),
	@lName varchar(35),
	@appnameId int
)
as

BEGIN TRANSACTION

BEGIN TRY
	declare @applicantId int

	select @applicantId = applicantid from ApplicantAppName where AppNameID = @appnameId
	
	insert into Contact (Firstname,Lastname)
	values (@fName,@lName)

	Insert into ACMembers (ContactID, ApplicantID)
	values (@@IDENTITY,@applicantId)

	

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