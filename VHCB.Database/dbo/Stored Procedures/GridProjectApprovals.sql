-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectApprovals]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Conserve.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS Approval, LookupValues_1.Description AS Disposition, dbo.ConserveApproval.ConserveApprovalID, dbo.ConserveApproval.ReqDate,
                       dbo.ConserveApproval.DispDate, dbo.ConserveApproval.Comments AS Comments, dbo.ConserveApproval.URL AS URL
FROM         dbo.Project INNER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ConserveApproval ON dbo.Conserve.ConserveID = dbo.ConserveApproval.ConserveID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ConserveApproval.LKDisp = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ConserveApproval.LKApproval = dbo.LookupValues.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ConserveApproval.RowIsActive = 1) AND (dbo.Conserve.ProjectID = @ProjID)
END