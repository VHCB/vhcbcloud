-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingUnitsSubType]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Housing.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      LookupValues_1.Description AS [Housing Category], dbo.LookupValues.Description AS [Housing Subtype], dbo.ProjectHouseSubType.Units, dbo.Housing.Previous, 
                      dbo.Housing.UnitsRemoved, dbo.Housing.NewUnits, dbo.Housing.TotalUnits,  dbo.ProjectHouseSubType.HousingTypeID

FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHouseSubType ON dbo.Housing.HousingID = dbo.ProjectHouseSubType.HousingID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectHouseSubType.LkHouseType = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Housing.LkHouseCat = LookupValues_1.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1) AND (dbo.Housing.ProjectID = @ProjID)
END