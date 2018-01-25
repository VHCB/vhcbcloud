-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcHOMERentUnits] 
	-- Add the parameters for the stored procedure here
	(@Proj as nchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     (rent50+rent65+rentmh) AS RentUnits
FROM         dbo.HOME INNER JOIN
                      dbo.Project ON dbo.HOME.ProjectId = dbo.Project.ProjectId
END