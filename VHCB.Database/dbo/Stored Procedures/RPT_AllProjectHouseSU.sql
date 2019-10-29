-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_AllProjectHouseSU]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Housing.ProjectID, SUM(dbo.HouseSource.Total) AS HSourcesTotal
FROM         dbo.Housing INNER JOIN
                      dbo.HouseSU ON dbo.Housing.HousingID = dbo.HouseSU.HousingId AND dbo.HouseSU.MostCurrent = 1 INNER JOIN
                      dbo.HouseSource ON dbo.HouseSU.HouseSUID = dbo.HouseSource.HouseSUID

GROUP BY dbo.Housing.ProjectID
END