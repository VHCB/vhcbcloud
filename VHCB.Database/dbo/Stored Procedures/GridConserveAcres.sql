-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveAcres]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveAcres.ConserveAcresID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS [Type of Acres], dbo.ConserveAcres.Acres AS [Acres/Ft.]
FROM         dbo.ConserveAcres LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveAcres.LkAcres = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.Conserve INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON dbo.Conserve.ProjectID = dbo.Project.ProjectId ON 
                      dbo.ConserveAcres.ConserveID = dbo.Conserve.ConserveID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveAcres.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END