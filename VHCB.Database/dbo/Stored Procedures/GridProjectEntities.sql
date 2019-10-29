-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectEntities]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT 
                      dbo.ProjectApplicant.ProjectId, dbo.Project.Proj_num, dbo.AppName.Applicantname, dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Address2, 
                      dbo.Address.Village, dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County, dbo.Address.latitude, dbo.Address.longitude, dbo.Applicant.email, 
                      dbo.Applicant.CellPhone, dbo.Applicant.Phone, dbo.Applicant.HomePhone, dbo.Applicant.WorkPhone, dbo.ProjectApplicant.ProjectApplicantID, 
                      dbo.ProjectApplicant.IsApplicant, dbo.ProjectApplicant.FinLegal, dbo.ProjectApplicant.Defapp, dbo.VWLK_ApplicantRole.Description AS [Applicant Role], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name]
FROM         dbo.VWLK_ApplicantRole RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId INNER JOIN
                      dbo.Applicant INNER JOIN
                      dbo.ApplicantAppName ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID ON dbo.ProjectApplicant.ApplicantId = dbo.Applicant.ApplicantId ON 
                      dbo.VWLK_ProjectNames.ProjectID = dbo.Project.ProjectId ON dbo.VWLK_ApplicantRole.TypeID = dbo.ProjectApplicant.LkApplicantRole LEFT OUTER JOIN
                      dbo.Address RIGHT OUTER JOIN
                      dbo.ApplicantAddress ON dbo.Address.AddressId = dbo.ApplicantAddress.AddressId ON dbo.ProjectApplicant.ApplicantId = dbo.ApplicantAddress.ApplicantId
 
WHERE     (dbo.ProjectApplicant.ProjectID=@ProjID) AND (dbo.Applicant.RowIsActive = 1) AND (dbo.ProjectApplicant.RowIsActive = 1) AND (dbo.VWLK_ProjectNames.DefName = 1)
End