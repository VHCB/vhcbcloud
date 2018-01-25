-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCheckReqItems] 
	(@PCRID as int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectCheckReqItems.ProjectCheckReqItems, dbo.ProjectCheckReqItems.ProjectCheckReqID, dbo.LookupValues.Description AS [CR Items]
FROM         dbo.ProjectCheckReqItems INNER JOIN
                      dbo.LookupValues ON dbo.ProjectCheckReqItems.LKCRItems = dbo.LookupValues.TypeID
             Where dbo.ProjectCheckReqitems.ProjectCheckReqID=@PCRID
END