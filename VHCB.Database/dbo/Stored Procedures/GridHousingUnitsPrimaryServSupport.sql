﻿-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingUnitsPrimaryServSupport]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Housing.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS Characteristic, dbo.ProjectHouseSuppServ.ProjectSuppServID, dbo.ProjectHouseSuppServ.Numunits
FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHouseSuppServ ON dbo.Housing.HousingID = dbo.ProjectHouseSuppServ.HousingID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectHouseSuppServ.LkSuppServ = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1) AND (dbo.ProjectHouseSuppServ.RowIsActive = 1) AND (dbo.Housing.ProjectID = @ProjID)
END