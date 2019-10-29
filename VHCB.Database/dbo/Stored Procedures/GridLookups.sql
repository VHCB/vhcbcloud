-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridLookups]
(
	@RecID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     TOP (100) PERCENT dbo.LkLookups.RecordID, dbo.LkLookups.Viewname, dbo.LookupValues.Description, dbo.LookupSubValues.SubDescription, dbo.LookupValues.SubReq,
                      dbo.LkLookups.Tiered, dbo.LookupValues.Ordering, dbo.LookupValues.TypeID
FROM         dbo.LkLookups INNER JOIN
                      dbo.LookupValues ON dbo.LkLookups.RecordID = dbo.LookupValues.LookupType LEFT OUTER JOIN
                      dbo.LookupSubValues ON dbo.LookupValues.TypeID = dbo.LookupSubValues.TypeID

Where (dbo.LkLookups.RecordID = @RecID)
ORDER BY dbo.LkLookups.Viewname
END