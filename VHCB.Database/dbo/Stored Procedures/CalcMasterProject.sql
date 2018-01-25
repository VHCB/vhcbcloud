-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcMasterProject] 
	-- Add the parameters for the stored procedure here
	--(@Proj as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     (LEFT(dbo.project.proj_num,8)) AS MProj
FROM         dbo.project 
order by MProj
                      
END