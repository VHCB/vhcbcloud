-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spProjectNames]
	-- Add the parameters for the stored procedure here
 (@Proj_Num as varchar(50))
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT     TOP (100) PERCENT dbo.ProjectName.ProjectID, dbo.Project.Proj_num, dbo.LookupValues.Description, dbo.ProjectName.DefName

FROM         dbo.ProjectName INNER JOIN
                      dbo.Project ON dbo.ProjectName.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectName.LkProjectname = dbo.LookupValues.TypeID
WHERE     (dbo.LookupValues.RowIsActive = 1) and (dbo.Project.Proj_num = @Proj_Num)
End