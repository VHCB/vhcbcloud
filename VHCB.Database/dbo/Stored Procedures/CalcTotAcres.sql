-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcTotAcres] 
	-- Add the parameters for the stored procedure here
	(@Proj as nchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT SUM(dbo.Acres.Tillable + dbo.Acres.Pasture + dbo.Acres.Wooded + dbo.Acres.Other) AS TotAcres
FROM         dbo.Acres INNER JOIN
                      dbo.Conserve ON dbo.Acres.ConserveID = dbo.Conserve.ConserveID
END