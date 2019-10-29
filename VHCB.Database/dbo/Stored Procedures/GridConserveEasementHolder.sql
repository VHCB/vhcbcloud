-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridConserveEasementHolder]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
                      dbo.Conserve.ProjectID, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.VWLK_ApplicantName.Applicantname AS [Easement Holder], dbo.Conserve.ConserveID, dbo.ConserveEholder.ConserveEholderID
FROM         dbo.VWLK_ProjectNames INNER JOIN
                      dbo.Conserve ON dbo.VWLK_ProjectNames.DefName = 1 AND dbo.VWLK_ProjectNames.ProjectID = dbo.Conserve.ProjectID RIGHT OUTER JOIN
                      dbo.ConserveEholder ON dbo.Conserve.ConserveID = dbo.ConserveEholder.ConserveID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.ConserveEholder.ApplicantId = dbo.VWLK_ApplicantName.ApplicantId
WHERE     (dbo.ConserveEholder.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END