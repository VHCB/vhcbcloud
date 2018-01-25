-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveLegalInt]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveLegInterest.ConserveLegInterestID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS [Legal Interest]
FROM         dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ConserveLegInterest ON dbo.Conserve.ConserveID = dbo.ConserveLegInterest.ConserveID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveLegInterest.LKLegInterest = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveLegInterest.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END