-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcHOMEBedUnits] 
	-- Add the parameters for the stored procedure here
	(@Proj as nchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     (uneff+un1br+un2br+un3br+un4br) AS BedUnits
FROM          dbo.Federal INNER JOIN
                      dbo.ProjectFederal ON dbo.Federal.FederalId = dbo.ProjectFederal.FederalID INNER JOIN
                      dbo.LkFedProg ON dbo.ProjectFederal.LkFedProgID = dbo.LkFedProg.TypeID INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId


--dbo.Federal INNER JOIN
--                      dbo.Project ON dbo.Federal.ProjectId = dbo.Project.ProjectId
END