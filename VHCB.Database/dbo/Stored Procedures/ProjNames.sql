-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ProjNames] 
	-- Add the parameters for the stored procedure here
--	(@Proj as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT     TOP (100) PERCENT dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.ProjectName.LkProjectname
FROM         dbo.Project INNER JOIN
                      dbo.ProjectName ON dbo.Project.ProjectId = dbo.ProjectName.LkProjectname
			  Where dbo.Project.ProjectID=1

ORDER BY dbo.ProjectName.LkProjectname
END