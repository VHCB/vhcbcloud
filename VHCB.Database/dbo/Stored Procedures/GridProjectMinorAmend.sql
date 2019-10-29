-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectMinorAmend]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS [Minor Amendment], LookupValues_1.Description AS Disposition, dbo.ConserveMinorAmend.ReqDate, 
                      dbo.ConserveMinorAmend.DispDate, dbo.ConserveMinorAmend.Comments, dbo.ConserveMinorAmend.URL, dbo.ConserveMinorAmend.ConserveMinAmendID

FROM         dbo.LookupValues RIGHT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ConserveMinorAmend ON dbo.Conserve.ConserveID = dbo.ConserveMinorAmend.ConserveID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ConserveMinorAmend.LkDisp = LookupValues_1.TypeID ON 
                      dbo.LookupValues.TypeID = dbo.ConserveMinorAmend.LkConsMinAmend
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)  AND (dbo.ConserveMinorAmend.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END