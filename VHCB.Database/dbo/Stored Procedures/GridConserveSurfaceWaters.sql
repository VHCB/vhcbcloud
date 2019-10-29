-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveSurfaceWaters]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT  distinct   dbo.ProjectSurfaceWaters.SurfaceWatersID, dbo.LookupValues.Description AS WaterShed, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectSurfaceWaters.SubWaterShed, LookupValues_1.Description AS WaterBody, 
                      dbo.ProjectSurfaceWaters.FrontageFeet
FROM         dbo.ProjectSurfaceWaters INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.ProjectSurfaceWaters.ProjectID = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 INNER JOIN
                      dbo.LookupValues ON dbo.ProjectSurfaceWaters.LKWaterShed = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectSurfaceWaters.LKWaterBody = LookupValues_1.TypeID
WHERE     (dbo.ProjectSurfaceWaters.RowIsActive = 1) AND (dbo.ProjectSurfaceWaters.ProjectID = @ProjID)
END