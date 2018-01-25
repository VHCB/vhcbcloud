-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingFederalProgramUnitSize]
(
	@ProjID				int)
--	@FedProg            int ) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
                      dbo.ProjectFederal.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      LookupValues_1.Description AS [Federal Program], dbo.LookupValues.Description AS [Unit Type]]], dbo.FederalUnit.NumUnits AS [Number of Units], 
                      dbo.FederalUnit.FederalUnitID
FROM         dbo.ProjectFederal INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectFederal.LkFedProg = LookupValues_1.TypeID INNER JOIN
                      dbo.FederalUnit ON dbo.ProjectFederal.ProjectFederalID = dbo.FederalUnit.ProjectFederalID INNER JOIN
                      dbo.LookupValues ON dbo.FederalUnit.UnitType = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederal.RowIsActive = 1) AND (dbo.FederalUnit.RowIsActive = 1) AND dbo.ProjectFederal.ProjectID = @ProjID
END