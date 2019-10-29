-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCheckReqDetail]
	-- Add the parameters for the stored procedure here
 (@PCRID as int)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT     dbo.Trans.TransId, dbo.Trans.Date, dbo.Trans.TransAmt, dbo.Trans.LkTransaction, dbo.LookupValues.Description AS [TransAction], dbo.Trans.ProjectCheckReqID, dbo.Detail.LkTransType, 
                      LookupValues_1.Description AS TransType, dbo.Detail.Amount, dbo.Detail.LandUsePermitID, dbo.Fund.name AS [Fund Name], 
                      dbo.StateAccount.StateAcctnum, dbo.Fund.account, dbo.Fund.DeptID, dbo.Fund.VHCBCode, dbo.Act250Farm.UsePermit, ProjectCheckReq.Voided
FROM         dbo.Trans INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
					  dbo.ProjectCheckReq ON dbo.Trans.ProjectCheckReqID = dbo.ProjectCheckReq.ProjectCheckReqID INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Detail.LkTransType = LookupValues_1.TypeID INNER JOIN
                      dbo.StateAccount ON dbo.Detail.LkTransType = dbo.StateAccount.LkTransType Left Outer JOIN
					  dbo.Act250Farm ON dbo.Detail.LandUsePermitID = dbo.Act250Farm.Act250FarmID 
            		  Where dbo.Trans.ProjectCheckReqID=@PCRID and dbo.Trans.LkTransaction=236
End