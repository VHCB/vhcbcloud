-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCheckReqQuestions]
	-- Add the parameters for the stored procedure here
 (@PCRID as int)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT     dbo.LkPCRQuestions.Description, dbo.ProjectCheckReqQuestions.ProjectCheckReqID, dbo.ProjectCheckReqQuestions.Approved, 
                      dbo.ProjectCheckReqQuestions.Date, dbo.UserInfo.Username
FROM         dbo.LkPCRQuestions INNER JOIN
                      dbo.ProjectCheckReqQuestions ON dbo.LkPCRQuestions.TypeID = dbo.ProjectCheckReqQuestions.LkPCRQuestionsID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectCheckReqQuestions.StaffID = dbo.UserInfo.UserId
WHERE     dbo.ProjectCheckReqQuestions.ProjectCheckReqID=@PCRID
END