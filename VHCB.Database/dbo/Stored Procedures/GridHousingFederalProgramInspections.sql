-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingFederalProgramInspections]
(
	@ProjID				int)
--	@FedProg            int ) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
                      dbo.ProjectFederal.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      LookupValues_1.Description AS [Federal Program], dbo.FederalProjectInspection.FederalProjectInspectionID, dbo.FederalProjectInspection.InspectDate, 
                      dbo.FederalProjectInspection.NextInspect, dbo.FederalProjectInspection.InspectLetter, dbo.FederalProjectInspection.RespDate, 
                      dbo.FederalProjectInspection.Deficiency, dbo.FederalProjectInspection.InspectDeadline, dbo.AppName.Applicantname
FROM         dbo.ApplicantAppName INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID INNER JOIN
                      dbo.ProjectFederal INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectFederal.LkFedProg = LookupValues_1.TypeID INNER JOIN
                      dbo.FederalProjectInspection ON dbo.ProjectFederal.ProjectFederalID = dbo.FederalProjectInspection.ProjectFederalID ON 
                      dbo.ApplicantAppName.ApplicantID = dbo.FederalProjectInspection.InspectStaff
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederal.RowIsActive = 1) AND (dbo.FederalProjectInspection.RowIsActive = 1) AND 
                      (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.FederalProjectInspection.RowIsActive = 1) AND dbo.ProjectFederal.ProjectID = @ProjID
END