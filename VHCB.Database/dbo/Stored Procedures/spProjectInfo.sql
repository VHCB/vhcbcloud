-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spProjectInfo] 
(@Projnum as nvarchar(12))
AS
BEGIN
	SET NOCOUNT ON;

SELECT     dbo.Project.Proj_num, LookupValues_1.Description AS [Project Name], dbo.VWLK_VHCBPrograms.Description AS [VHCB Program], 
                      dbo.VWLK_AppStatus.Description AS [Application Status], dbo.VWLK_ProjectStatus.Description AS [Proj Status], dbo.VWLK_ProjectTypes.Description AS [Proj Type], 
                      dbo.LkBoardDate.BoardDate, dbo.UserInfo.Fname, dbo.UserInfo.Lname, dbo.ProjectName.DefName, dbo.AppName.Applicantname
FROM         dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.ProjectName ON dbo.Project.ProjectId = dbo.ProjectName.ProjectID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.ProjectName.LkProjectname = LookupValues_1.TypeID INNER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.Project.LkProgram = dbo.VWLK_VHCBPrograms.TypeID INNER JOIN
                      dbo.VWLK_AppStatus ON dbo.Project.LkAppStatus = dbo.VWLK_AppStatus.TypeID INNER JOIN
                      dbo.VWLK_ProjectStatus ON dbo.Project.LkPStatus = dbo.VWLK_ProjectStatus.TypeID INNER JOIN
                      dbo.VWLK_ProjectTypes ON dbo.Project.LkProjectType = dbo.VWLK_ProjectTypes.TypeID INNER JOIN
                      dbo.LkBoardDate ON dbo.Project.LkBoardDate = dbo.LkBoardDate.TypeID INNER JOIN
                      dbo.UserInfo ON dbo.Project.Manager = dbo.UserInfo.UserId INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId ON dbo.ApplicantAppName.ApplicantID = dbo.ProjectApplicant.ApplicantId
WHERE     (dbo.Project.Proj_num = @Projnum) AND (dbo.ApplicantAppName.DefName = 1)
END