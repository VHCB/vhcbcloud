-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcEasementValue] 
	-- Add the parameters for the stored procedure here
	(@Proj as nvarchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     (apbef-apaft) AS EaseVal
FROM         dbo.Conserve INNER JOIN
                      dbo.Project ON dbo.conserve.ProjectId = dbo.Project.ProjectId
END