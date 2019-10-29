-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectMajorAmend]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ConserveMajorAmend.ConserveMajAmendID, dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LookupValues.Description AS [Major Amendment], LookupValues_1.Description AS Disposition, 
                      dbo.ConserveMajorAmend.DispDate, dbo.ConserveMajorAmend.Comments, dbo.ConserveMajorAmend.URL, dbo.ConserveMajorAmend.ReqDate
FROM         dbo.ConserveMajorAmend INNER JOIN
                      dbo.Conserve ON dbo.ConserveMajorAmend.ConserveID = dbo.Conserve.ConserveID INNER JOIN
                      dbo.Project ON dbo.Conserve.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ConserveMajorAmend.LkDisp = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveMajorAmend.LkConsMajAmend = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)  AND (dbo.ConserveMajorAmend.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END