-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveOType]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveOType.ConserveOTypeID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS [Owner Type]
FROM         dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ConserveOType ON dbo.Conserve.ConserveID = dbo.ConserveOType.ConserveID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveOType.LKOType = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveOType.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END