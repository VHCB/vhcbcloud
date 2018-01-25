-- =============================================
-- Author:		<Dan>
-- Create date: <7/11/14>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RelatedProjects] 
	-- Add the parameters for the stored procedure here
	@Proj as nvarchar(12)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
                      TOP (100) PERCENT dbo.ProjectName.DefName, dbo.Project.Proj_num, dbo.ProjectName.ProjectID, dbo.LkProjectName.Proj_name, 
                      dbo.ProjectRelated.ProjectID AS PID, dbo.ProjectRelated.Related$, Project_1.Proj_num AS Expr1
FROM         dbo.ProjectRelated INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.ProjectName INNER JOIN
                      dbo.LkProjectName ON dbo.ProjectName.LkProjectname = dbo.LkProjectName.NameID ON dbo.Project.ProjectId = dbo.ProjectName.ProjectID ON 
                      dbo.ProjectRelated.RelProjectID = dbo.ProjectName.ProjectID INNER JOIN
                      dbo.Project AS Project_1 ON dbo.ProjectRelated.ProjectID = Project_1.ProjectId
Where Project_1.Proj_num=@Proj
--GROUP BY dbo.Project.Proj_num, dbo.ProjectName.ProjectID, dbo.LkProjectName.Proj_name, dbo.ProjectRelated.ProjectID, dbo.ProjectRelated.Related$, Project_1.Proj_num, 
--                      dbo.ProjectName.DefName
ORDER BY dbo.ProjectName.ProjectID, dbo.ProjectName.DefName
End