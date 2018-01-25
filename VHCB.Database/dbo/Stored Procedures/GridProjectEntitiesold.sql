-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectEntitiesold]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Distinct 
                      dbo.ProjectApplicant.ProjectId, dbo.AppName.Applicantname, dbo.ProjectApplicant.FinLegal, dbo.LookupValues.Description, dbo.Applicant.email, 
                      dbo.Applicant.HomePhone, dbo.Applicant.WorkPhone, dbo.Applicant.CellPhone, dbo.ProjectApplicant.IsApplicant, 
                      dbo.ProjectApplicant.Defapp,dbo.ProjectApplicant.ProjectApplicantID,dbo.Applicant.website, dbo.Applicant.FYend, dbo.ProjectApplicant.RowIsActive

FROM         dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID INNER JOIN
                      dbo.Applicant ON dbo.ApplicantAppName.ApplicantID = dbo.Applicant.ApplicantId INNER JOIN
                      dbo.ProjectApplicant ON dbo.ApplicantAppName.ApplicantID = dbo.ProjectApplicant.ApplicantId LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectApplicant.LkApplicantRole = dbo.LookupValues.TypeID
					  where dbo.ProjectApplicant.ProjectID=@ProjID and dbo.ProjectApplicant.RowIsActive=1
END