-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectMilestones]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT DISTINCT 
                      dbo.ProjectEvent.ProjectEventID, dbo.Project.Proj_num AS [Project Number], dbo.ProjectEvent.ProjectID, dbo.VWLK_ProjectNames.Description AS ProjectName, 
                      dbo.VWLK_VHCBPrograms.Description AS Program, LookupValues_1.Description AS [Admin Milestone], 
                      dbo.LookupSubValues.SubDescription AS [Admin SubMilestone], dbo.LookupValues.Description AS [Program Milestone], 
                      LookupSubValues_1.SubDescription AS [Program SubMilestone], dbo.ProjectEvent.Date, dbo.ProjectEvent.Note, dbo.UserInfo.Username, 
                      dbo.VWLK_ApplicantName.Applicantname, dbo.ProjectEvent.URL
FROM         dbo.Project RIGHT OUTER JOIN
                      dbo.ProjectEvent ON dbo.Project.ProjectId = dbo.ProjectEvent.ProjectID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectEvent.ProgEventID = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_1 ON dbo.ProjectEvent.ProgSubEventID = LookupSubValues_1.SubTypeID LEFT OUTER JOIN
                      dbo.LookupSubValues ON dbo.ProjectEvent.SubEventID = dbo.LookupSubValues.SubTypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectEvent.EventID = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.ProjectEvent.Prog = dbo.VWLK_VHCBPrograms.TypeID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.ProjectEvent.ApplicantID = dbo.VWLK_ApplicantName.ApplicantId LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectEvent.RowIsActive = 1) AND (dbo.ProjectEvent.ProjectID = @ProjID)
END