-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcTotRequest$] 
	-- Add the parameters for the stored procedure here
	(@Proj as nchar)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     dbo.ProjectRequests.ProjectId, dbo.Project.Proj_num, dbo.ProjectRequests.RequestTypeId, sum(dbo.ProjectRequests.Amount)as TotAmt$
FROM         dbo.Project INNER JOIN
                      dbo.ProjectRequests ON dbo.Project.ProjectId = dbo.ProjectRequests.ProjectId
Where dbo.Project.Proj_num=@Proj   
Group by dbo.ProjectRequests.ProjectId, dbo.Project.Proj_num, dbo.ProjectRequests.RequestTypeId 

                
END