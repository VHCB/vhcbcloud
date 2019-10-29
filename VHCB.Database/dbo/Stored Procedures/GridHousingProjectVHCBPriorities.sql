-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingProjectVHCBPriorities]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
                      dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS Priorities, dbo.Project.ProjectId, 
                      dbo.ProjectVHCBPriorities.ProjectVHCBPrioritiesID
FROM         dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectVHCBPriorities ON dbo.Project.ProjectId = dbo.ProjectVHCBPriorities.ProjectID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectVHCBPriorities.LkVHCBPriorities = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Project.RowIsActive = 1) AND 
                      (dbo.ProjectVHCBPriorities.RowIsActive = 1) AND (dbo.Project.ProjectID = @ProjID)
END