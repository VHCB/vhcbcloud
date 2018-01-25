-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingProjectConsPlanPrioities]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
                      dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS Priorities, 
                      dbo.Project.ProjectId,ProjectConPlanPriorities.ProjectConPlanPrioritiesID
FROM         dbo.ProjectConPlanPriorities INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON dbo.ProjectConPlanPriorities.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectConPlanPriorities.LkConplanPriorities = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectConPlanPriorities.RowIsActive = 1) AND 
                      (dbo.Project.RowIsActive = 1) AND (dbo.Project.ProjectID = @ProjID)
END