-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllFinancialFundDetails2]
	-- Add the parameters for the stored procedure here
	-- @proj_num varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
                      dbo.Trans.TransId, dbo.Detail.DetailID, dbo.Trans.ProjectID, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Trans.Date, dbo.Trans.TransAmt, 
                      dbo.Trans.PayeeApplicant, dbo.Detail.FundId, dbo.Detail.Amount, dbo.Trans.ProjectCheckReqID, dbo.Project.Proj_num, dbo.AppName.Applicantname AS Payee, 
                      dbo.VWLK_ApplicantName.Applicantname, dbo.VWLK_FinancialTransactionAction.Description AS [Transaction], 
                      dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], dbo.VWLK_FinancialTransStatus.Description AS Status, dbo.Fund.name AS [Fund Name]
FROM         dbo.Fund INNER JOIN
                      dbo.VWLK_FinancialTransactionType INNER JOIN
                      dbo.Detail ON dbo.VWLK_FinancialTransactionType.TypeID = dbo.Detail.LkTransType ON dbo.Fund.FundId = dbo.Detail.FundId LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionAction INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_ApplicantName ON dbo.Project.ProjectId = dbo.VWLK_ApplicantName.ProjectId ON 
                      dbo.VWLK_FinancialTransactionAction.TypeID = dbo.Trans.LkTransaction ON dbo.Detail.TransId = dbo.Trans.TransId LEFT OUTER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.Trans.PayeeApplicant = dbo.ApplicantAppName.ApplicantID LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransStatus ON dbo.Trans.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID
--					  where dbo.Project.Proj_num=@proj_num
END