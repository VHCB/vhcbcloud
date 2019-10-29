-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectDescription] 
	-- Add the parameters for the stored procedure here
	(@DescID as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     TOP (100) PERCENT dbo.LookupValues.TableID, dbo.LkLookups.Viewname, dbo.LookupValues.TypeID, dbo.LookupValues.Description
                      
FROM         dbo.LookupValues INNER JOIN
                      dbo.LkLookups ON dbo.LookupValues.TableID = dbo.LkLookups.TableID
Where dbo.LookupValues.TableID=@DescID 	
ORDER BY dbo.LookupValues.TableID, dbo.LookupValues.TypeID, dbo.LookupValues.Description DESC

END