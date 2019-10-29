-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingUses]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Project.ProjectId, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], LookupValues_1.Description AS Uses, 
                      dbo.Housing.HousingID, dbo.HouseSU.LkBudgetPeriod, dbo.LookupValues.Description as [Budget Period], dbo.HouseSU.MostCurrent, dbo.HouseUse.VHCBTotal
FROM         dbo.LookupValues INNER JOIN
                      dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId AND dbo.Housing.RowIsActive = 1 INNER JOIN
                      dbo.HouseSU ON dbo.Housing.HousingID = dbo.HouseSU.HousingId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 ON 
                      dbo.LookupValues.TypeID = dbo.HouseSU.LkBudgetPeriod INNER JOIN
                      dbo.HouseUse ON dbo.HouseSU.HouseSUID = dbo.HouseUse.HouseSUID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.HouseUse.LkHouseUseVHCB = LookupValues_1.TypeID
Where (dbo.Project.ProjectID = @ProjID)
END