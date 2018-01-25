-- =============================================
-- Author:		<Author,Dan>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckReqDetail] 
	-- Add the parameters for the stored procedure here
	(@CheckReqID as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Fund.name, SUM(dbo.Detail.Amount) AS amount, dbo.LkTransType.Description, 
	dbo.FundTransType.StateID, dbo.Fund.StateAcct, dbo.Fund.account
FROM         dbo.ProjectCheckReq INNER JOIN
                      dbo.Trans ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.Trans.ProjectCheckReqID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LkTransType ON dbo.Detail.LkTransType = dbo.LkTransType.TypeId INNER JOIN
                      dbo.FundTransType ON dbo.Fund.FundId = dbo.FundTransType.FundId AND 
					  dbo.Fund.LkFundType = dbo.FundTransType.LkTransType CROSS JOIN
                      dbo.Project
Where dbo.Trans.ProjectCheckReqID = @CheckReqID
GROUP BY dbo.Trans.ProjectCheckReqID, dbo.Fund.name, dbo.LkTransType.Description, dbo.FundTransType.StateID, 
dbo.Fund.StateAcct, dbo.Fund.account

END