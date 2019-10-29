 
CREATE FUNCTION dbo.GetApplicantName
    (
      @applicantId INT 
    )
RETURNS varchar(150)
AS 
    BEGIN
        DECLARE @ApplicantName AS varchar(150) ;
 
	select top 1 
		@ApplicantName = an.applicantname 
	from applicantappname aan(nolock) 
	join appname an(nolock) on aan.appnameid = an.appnameid
	join applicant a(nolock) on a.applicantid = aan.applicantid
	where aan.applicantId = @applicantId

	RETURN  @ApplicantName ;
    END