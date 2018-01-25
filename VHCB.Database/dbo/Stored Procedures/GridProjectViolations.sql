-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectViolations]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveViolations.ConserveViolationsID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS Violation, LookupValues_1.Description AS Disposition, 
                      dbo.ConserveViolations.ReqDate AS [Required Date], dbo.ConserveViolations.DispDate AS [Disposition Date], dbo.ConserveViolations.Comments, 
                      dbo.ConserveViolations.URL
FROM         dbo.LookupValues AS LookupValues_1 RIGHT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ConserveViolations ON dbo.Conserve.ConserveID = dbo.ConserveViolations.ConserveID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveViolations.LkConsViol = dbo.LookupValues.TypeID ON LookupValues_1.TypeID = dbo.ConserveViolations.LkDisp
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveViolations.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END