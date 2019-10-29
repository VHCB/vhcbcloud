-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectManagePlan]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS ManagementPlan, dbo.ConservePlan.ConservePlanID, dbo.ConservePlan.DispDate AS Date, dbo.ConservePlan.Comments, 
                      dbo.ConservePlan.URL
FROM         dbo.LookupValues RIGHT OUTER JOIN
                      dbo.ConservePlan INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON dbo.ConservePlan.ConserveID = dbo.Conserve.ConserveID ON 
                      dbo.LookupValues.TypeID = dbo.ConservePlan.LKManagePlan
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConservePlan.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END