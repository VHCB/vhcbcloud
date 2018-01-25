-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCommitted_Funds]
	-- Add the parameters for the stored procedure here
--	<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT DISTINCT 
                      dbo.Trans.Date, SUM(dbo.Trans.TransAmt) AS TotAmount, dbo.LookupValues.Description, dbo.Trans.PayeeApplicant, LookupValues_1.Description AS PendFinal, 
                      dbo.AppName.Applicantname, dbo.Trans.LkTransaction, dbo.Fund.name AS FundName, dbo.ProjectName.LkProjectname, LookupValues_2.Description AS ProjName, 
                      dbo.Project.Proj_num
FROM         dbo.Trans INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID AND dbo.Trans.LkTransaction = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkStatus = LookupValues_1.TypeID INNER JOIN
                      dbo.Applicant ON dbo.Trans.PayeeApplicant = dbo.Applicant.ApplicantId INNER JOIN
                      dbo.ApplicantAppName ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.ApplicantAppNameID = dbo.AppName.AppNameID INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.ProjectName ON dbo.Trans.ProjectID = dbo.ProjectName.ProjectID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.ProjectName.LkProjectname = LookupValues_2.TypeID INNER JOIN
                      dbo.Project ON dbo.ProjectName.ProjectID = dbo.Project.ProjectId
GROUP BY dbo.Trans.Date, dbo.Trans.TransAmt, dbo.LookupValues.Description, dbo.Trans.PayeeApplicant, LookupValues_1.Description, dbo.AppName.Applicantname, 
                      dbo.Trans.LkTransaction, dbo.Fund.name, dbo.ProjectName.LkProjectname, LookupValues_2.Description, dbo.Project.Proj_num
END