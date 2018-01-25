CREATE procedure [dbo].[AddNewApplicant]

	@fName varchar(20) =null,
	@lName	varchar(35) =null,
	@fullName varchar(60) =null,
	@finLegal bit,
	@isIndividual bit

as
BEGIN TRANSACTION

BEGIN TRY
	declare @ContactId int;
	Declare @applicantId int;
	declare @appnameId int;

	if (@isIndividual= 1)
	Begin
		insert into Contact (Firstname,Lastname,FinLegal)
		values (@fName,@lName,@finLegal)

		set @ContactId = @@IDENTITY;

		insert into Applicant(FinLegal, Individual)
		values (@finLegal, 1)

		set @applicantId = @@IDENTITY;

		insert into ApplicantContact (ApplicantID,ContactID,DfltCont)
		values (@applicantId,@ContactId, 1)

		insert into AppName (Applicantname) values ( @lName +', '+ @fName)
		set @appnameId = @@IDENTITY	

		Insert into ApplicantAppName (ApplicantId,AppNameID,DefName)
		values (@applicantId, @appnameId, 1)

	end
	else 
	Begin
		insert into Applicant(FinLegal, Individual)
		values (@finLegal, 0)
		set @applicantId = @@IDENTITY;

		Insert into AppName (Applicantname)
		values (@fullName)
		set @appnameId = @@IDENTITY	

		Insert into ApplicantAppName (ApplicantId,AppNameID,DefName)
		values (@applicantId, @appnameId, 1)

	end

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