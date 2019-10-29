-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectNames]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectName.ProjectID, dbo.Project.Proj_num, dbo.LookupValues.Description, dbo.LookupValues.RowIsActive, dbo.ProjectName.Defname
FROM         dbo.ProjectName INNER JOIN
                      dbo.Project ON dbo.ProjectName.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectName.LkProjectname = dbo.LookupValues.TypeID
					  where dbo.ProjectName.ProjectID=@ProjID and dbo.LookupValues.RowIsActive=1
END