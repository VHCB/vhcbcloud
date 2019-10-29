-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridFinancialCommitments]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.Trans.ProjectID, dbo.Trans.TransID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Trans.Date AS [Transaction Date], 
                      dbo.Trans.TransAmt AS [Transaction Amount], dbo.AppName.Applicantname AS Payee, LookupValues_1.Description AS [Trans Action], 
                      LookupValues_2.Description AS Status, dbo.Detail.DetailID, dbo.Fund.name AS Fund, dbo.LookupValues.Description AS [Trans Type], 
                      dbo.Detail.Amount AS [Detail Amount]
FROM         dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID RIGHT OUTER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkTransaction = LookupValues_1.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID ON dbo.ApplicantAppName.ApplicantID = dbo.Trans.PayeeApplicant
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Detail.RowIsActive = 1) AND (dbo.Trans.RowIsActive = 1) AND (dbo.ApplicantAppName.DefName = 1) AND (dbo.Trans.ProjectID = @ProjID)
END