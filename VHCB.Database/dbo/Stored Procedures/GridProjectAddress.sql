-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectAddress]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectAddress.ProjectId, dbo.ProjectAddress.RowIsActive, dbo.LookupValues.Description AS [Address Type], dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Address2, 
                      dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County, dbo.ProjectAddress.PrimaryAdd,dbo.Address.Village

FROM         dbo.Address INNER JOIN
                      dbo.ProjectAddress ON dbo.Address.AddressId = dbo.ProjectAddress.AddressId left JOIN
                  dbo.LookupValues ON dbo.Address.LkAddressType = dbo.LookupValues.TypeID
					  where dbo.ProjectAddress.ProjectId=@ProjID and dbo.ProjectAddress.RowIsActive=1
END