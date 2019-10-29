-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[spCheckReqNotes] 
	(@PCRID as int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectNotes.ProjectNotesID, dbo.ProjectNotes.ProjectCheckReqID, dbo.ProjectNotes.Date, dbo.ProjectNotes.Notes, dbo.ProjectNotes.URL, 
                      dbo.LookupValues.Description AS Category
FROM         dbo.ProjectNotes INNER JOIN
                      dbo.ProjectCheckReq ON dbo.ProjectNotes.ProjectCheckReqID = dbo.ProjectCheckReq.ProjectCheckReqID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectNotes.LkCategory = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectNotes.UserId = dbo.UserInfo.UserId
             Where dbo.ProjectNotes.ProjectCheckReqID=@PCRID
END