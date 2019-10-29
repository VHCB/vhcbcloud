-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingUnitsAgeRestrict]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Housing.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS Characteristic, dbo.ProjectHouseAgeRestrict.Numunits, dbo.ProjectHouseAgeRestrict.ProjectAgeRestrictID
FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHouseAgeRestrict ON dbo.Housing.HousingID = dbo.ProjectHouseAgeRestrict.HousingID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectHouseAgeRestrict.LKAgeRestrict = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1) AND (dbo.ProjectHouseAgeRestrict.RowIsActive = 1) AND (dbo.Housing.ProjectID = @ProjID)
END