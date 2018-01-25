-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveEHolder]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveEholder.ConserveEholderID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.AppName.Applicantname
FROM         dbo.ApplicantAppName INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID RIGHT OUTER JOIN
                      dbo.ConserveEholder INNER JOIN
                      dbo.Conserve ON dbo.ConserveEholder.ConserveID = dbo.Conserve.ConserveID INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON dbo.Conserve.ProjectID = dbo.Project.ProjectId ON 
                      dbo.ApplicantAppName.ApplicantID = dbo.ConserveEholder.ApplicantId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveEholder.RowIsActive = 1) AND (dbo.ApplicantAppName.DefName = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END