-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectIncomeRestrict]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT DISTINCT 
                      dbo.ProjectFederalIncomeRest.ProjectFederalIncomeRestID, dbo.Project.ProjectId, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS [Restricted Unit], dbo.ProjectFederalIncomeRest.Numunits, 
                      LookupValues_1.Description AS [Federal Program], dbo.ProjectFederal.NumUnits AS [Total Units], dbo.ProjectFederal.RowIsActive
FROM         dbo.ProjectFederalIncomeRest INNER JOIN
                      dbo.ProjectFederal ON dbo.ProjectFederalIncomeRest.ProjectFederalID = dbo.ProjectFederal.ProjectFederalID INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectFederalIncomeRest.LkAffordunits = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectFederal.LkFedProg = LookupValues_1.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederalIncomeRest.RowIsActive = 1) AND (dbo.ProjectFederal.RowIsActive = 1) and dbo.Project.ProjectId=@ProjID
End