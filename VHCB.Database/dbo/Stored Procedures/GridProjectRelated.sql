-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectRelated]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.Project.ProjectId, dbo.Project.Proj_num AS [ProjectNumber], dbo.ProjectRelated.ProjectID AS [RelatedProjectID], 
                      dbo.VWLK_ProjectNames.Description AS [RelatedName], dbo.VWLK_VHCBPrograms.Description AS [RelatedProgram], Project_1.Proj_num AS [RelNumber]
FROM         dbo.Project INNER JOIN
                      dbo.ProjectRelated ON dbo.Project.ProjectId = dbo.ProjectRelated.RelProjectID INNER JOIN
                      dbo.Project AS Project_1 ON dbo.ProjectRelated.ProjectID = Project_1.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON Project_1.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_VHCBPrograms ON Project_1.LkProgram = dbo.VWLK_VHCBPrograms.TypeID
WHERE     dbo.VWLK_ProjectNames.DefName = 1 AND dbo.ProjectRelated.RowIsActive = 1 and dbo.Project.ProjectId=@ProjID
End