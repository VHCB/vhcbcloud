
CREATE PROCEDURE [dbo].[SP_RPT_FinancialFundTotalsbyProject]
(
	@startDate datetime,
	@endDate datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT   dbo.Project.ProjectId,  sum(dbo.Detail.Amount) as Tot_Amt, dbo.LkFundType.Description AS [Fund Type]
                      
FROM         dbo.LkFundType INNER JOIN
                      dbo.Detail INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId ON dbo.LkFundType.TypeId = dbo.Fund.LkFundType INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID
WHERE     dbo.Trans.LkTransaction IN (238, 239, 240) AND (trans.Date between @startDate and @endDate) AND Trans.rowisactive=1
GROUP BY  dbo.Project.ProjectId, dbo.LkFundType.Description
ORDER BY dbo.Project.ProjectId, [Fund Type]
END