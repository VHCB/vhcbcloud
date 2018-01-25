-- =============================================
-- Author:		<Author,Dan>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckRequest] 
	-- Add the parameters for the stored procedure here
	(@CheckReqID as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.Project.Proj_num, dbo.ApplicantName.Applicantname, dbo.ProjectName.Proj_name, sum (dbo.Trans.TransAmt) as amount, dbo.ProjectCheckReq.Final, 
                      dbo.ProjectCheckReq.ReqDate, dbo.ProjectCheckReq.Voucher#, dbo.ProjectCheckReq.VoucherDate, dbo.LkProgram.Description, 
                      dbo.LkNOD.Description AS [Nature of Disburse], dbo.LkPCRQuestions.Description AS Validation, dbo.Trans.Date
FROM         dbo.ProjectCheckReq INNER JOIN
                      dbo.Trans ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.Trans.ProjectCheckReqID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.ProjectApplicant ON dbo.Trans.PayeeApplicant = dbo.ProjectApplicant.ProjectApplicantID INNER JOIN
                      dbo.ApplicantName ON dbo.ProjectApplicant.ApplicantId = dbo.ApplicantName.ApplicantId INNER JOIN
                      dbo.ProjectName ON dbo.Project.ProjectId = dbo.ProjectName.ProjectID INNER JOIN
                      dbo.LkProgram ON dbo.ProjectCheckReq.LkProgram = dbo.LkProgram.TypeId INNER JOIN
                      dbo.LkNOD ON dbo.ProjectCheckReq.LkNOD = dbo.LkNOD.TypeID INNER JOIN
                      dbo.PCRPCRQuestions ON dbo.ProjectCheckReq.ProjectCheckReqID = dbo.PCRPCRQuestions.ProjectCheckReqID INNER JOIN
                      dbo.PCRQuestions ON dbo.PCRPCRQuestions.PCRQuestionID = dbo.PCRQuestions.PCRQuestionID INNER JOIN
                      dbo.LkPCRQuestions ON dbo.PCRQuestions.LkPCRQuestion = dbo.LkPCRQuestions.TypeID
WHERE     (dbo.ApplicantName.DefName = 1) AND (dbo.ProjectName.DefName = 1) and dbo.Trans.ProjectCheckReqID = @CheckReqID
GROUP BY dbo.Trans.ProjectCheckReqID, dbo.Project.Proj_num, dbo.ApplicantName.Applicantname, dbo.ProjectName.Proj_name, 
dbo.Fund.name, dbo.Fund.StateAcct, dbo.Fund.account, dbo.ProjectCheckReq.Final, dbo.ProjectCheckReq.ReqDate, 
dbo.ProjectCheckReq.Voucher#, dbo.ProjectCheckReq.VoucherDate, dbo.LkProgram.Description,  dbo.LkNOD.Description, dbo.LkPCRQuestions.Description,
dbo.Trans.Date

END