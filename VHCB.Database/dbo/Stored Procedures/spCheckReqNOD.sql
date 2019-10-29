-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCheckReqNOD] 
	(@PCRID as int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectCheckReqNOD.ProjectCheckReqNOD, dbo.ProjectCheckReqNOD.ProjectCheckReqID, dbo.ProjectCheckReq.ProjectID, dbo.LookupValues.Description, 
                      dbo.ProjectFederalDetail.CHDO, dbo.ProjectFederalDetail.IDISNum
FROM         dbo.ProjectFederalDetail INNER JOIN
                      dbo.ProjectFederal ON dbo.ProjectFederalDetail.ProjectFederalId = dbo.ProjectFederal.ProjectFederalID RIGHT OUTER JOIN
                      dbo.ProjectCheckReqNOD INNER JOIN
                      dbo.ProjectCheckReq ON dbo.ProjectCheckReqNOD.ProjectCheckReqID = dbo.ProjectCheckReq.ProjectCheckReqID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectCheckReqNOD.LKNOD = dbo.LookupValues.TypeID INNER JOIN
                      dbo.Project ON dbo.ProjectCheckReq.ProjectID = dbo.Project.ProjectId ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId
             Where dbo.ProjectCheckReqNOD.ProjectCheckReqID=@PCRID
END