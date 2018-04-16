-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCheckReqHeader]
	-- Add the parameters for the stored procedure here
 @PCRID as int
--(@ProjID as int), (@Projnum as nvarchar(12)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  top 1   dbo.Project.Proj_num, dbo.LookupValues.Description AS Program, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectCheckReq.InitDate, 
                      dbo.ProjectCheckReq.LegalReview, dbo.ProjectCheckReq.MatchAmt, LookupValues_1.Description AS [Grant Match], dbo.ProjectCheckReq.Notes, 
                      dbo.ProjectCheckReq.LCB, dbo.ProjectCheckReq.ProjectID, dbo.ProjectCheckReq.Paiddate, dbo.AppName.Applicantname AS Payee, AppName_1.Applicantname, 
                      dbo.ProjectCheckReq.Voucher#, LookupValues_2.Description AS Status,  dbo.Trans.TransId, dbo.ProjectCheckReq.ProjectCheckReqID, dbo.ProjectCheckReq.Coordinator, dbo.ProjectCheckReq.CRDate, dbo.UserInfo.UserName,dbo.Trans.LkTransaction, dbo.Applicant.Stvendid

FROM         dbo.ProjectCheckReq INNER JOIN
                      dbo.Project ON dbo.ProjectCheckReq.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.LookupValues ON dbo.ProjectCheckReq.LkProgram = dbo.LookupValues.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.Trans ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.Trans.ProjectCheckReqID INNER JOIN
                      dbo.ApplicantAppName ON dbo.Trans.PayeeApplicant = dbo.ApplicantAppName.ApplicantID LEFT OUTER JOIN
					  dbo.Applicant ON dbo.Applicant.ApplicantId = dbo.ApplicantAppName.ApplicantID LEFT OUTER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID LEFT OUTER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId LEFT OUTER JOIN
                      dbo.ApplicantAppName AS ApplicantAppName_1 ON dbo.ProjectApplicant.ApplicantId = ApplicantAppName_1.ApplicantID LEFT OUTER JOIN
                      dbo.AppName AS AppName_1 ON ApplicantAppName_1.AppNameID = AppName_1.AppNameID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectCheckReq.LkFVGrantMatch = LookupValues_1.TypeID LEFT OUTER JOIN
					  dbo.UserInfo ON dbo.ProjectCheckReq.UserID = dbo.UserInfo.UserId
WHERE     (dbo.ProjectCheckReq.ProjectCheckReqID=@PCRID and dbo.ProjectApplicant.Defapp = 1) and dbo.ApplicantAppName.DefName=1 and dbo.VWLK_ProjectNames.Defname=1 and dbo.trans.LkTransaction=236 and dbo.ProjectApplicant.FinLegal=1
END