-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_AllProjectConserveSU]


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Conserve.ProjectID, SUM(dbo.ConserveSources.Total) AS CSourcesTotal
FROM         dbo.Conserve INNER JOIN
                      dbo.ConserveSU ON dbo.Conserve.ConserveID = dbo.ConserveSU.ConserveID AND dbo.ConserveSU.MostCurrent = 1 INNER JOIN
                      dbo.ConserveSources ON dbo.ConserveSU.ConserveSUID = dbo.ConserveSources.ConserveSUID

GROUP BY dbo.Conserve.ProjectID

END