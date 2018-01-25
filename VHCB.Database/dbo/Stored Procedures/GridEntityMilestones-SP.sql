-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridEntityMilestones-SP]
(
	@ApplicantID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT     dbo.ProjectEvent.ProjectEventID, dbo.AppName.Applicantname AS [Applicant Name], LookupValues_2.Description AS [Entity Milestone], dbo.ProjectEvent.Date, 
                      dbo.ProjectEvent.Note, dbo.ProjectEvent.URL, dbo.UserInfo.Username, LookupSubValues_2.SubDescription AS [Entity Sub], dbo.ApplicantAppName.ApplicantID
FROM         dbo.LookupValues AS LookupValues_2 RIGHT OUTER JOIN
                      dbo.ProjectEvent LEFT OUTER JOIN
                      dbo.LookupSubValues AS LookupSubValues_2 ON dbo.ProjectEvent.EntitySubMSID = LookupSubValues_2.SubTypeID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.AppName RIGHT OUTER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON dbo.ProjectEvent.ApplicantID = dbo.ApplicantAppName.ApplicantID ON 
                      LookupValues_2.TypeID = dbo.ProjectEvent.EntityMSID
WHERE     (dbo.ProjectEvent.RowIsActive = 1) and dbo.ProjectEvent.ApplicantID=@ApplicantID
end