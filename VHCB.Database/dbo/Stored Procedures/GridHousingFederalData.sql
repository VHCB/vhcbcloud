-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridHousingFederalData]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT 
                      dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.ProjectFederal.ProjectID, dbo.ProjectFederal.ProjectFederalID, 
                      dbo.ProjectFederal.NumUnits, dbo.LookupValues.Description AS [Federal Program], dbo.ProjectFederalProgramDetail.AffrdPeriod, 
                      dbo.ProjectFederalProgramDetail.AffrdStart, dbo.ProjectFederalProgramDetail.AffrdEnd, LookupValues_1.Description AS [Recertification Month], 
                      LookupValues_2.Description AS [Afford Period], dbo.ProjectFederalProgramDetail.freq AS [Inspection Freq], dbo.ProjectFederalProgramDetail.IDISNum, 
                      dbo.ProjectFederalProgramDetail.Setup, dbo.ProjectFederalProgramDetail.FundedDate, dbo.ProjectFederalProgramDetail.IDISClose, 
                      dbo.UserInfo.Username AS [Fund Completed By], UserInfo_1.Username AS [Completed By], UserInfo_2.Username AS [IDIS Completed By], 
                      dbo.ProjectFederalProgramDetail.CHDO, LookupValues_3.Description AS [CHDO Recert], dbo.ProjectFederalProgramDetail.IsUARegulation
FROM         dbo.LookupValues AS LookupValues_1 RIGHT OUTER JOIN
                      dbo.ProjectFederalProgramDetail ON LookupValues_1.TypeID = dbo.ProjectFederalProgramDetail.Recert LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.ProjectFederalProgramDetail.LKAffrdPer = LookupValues_2.TypeID LEFT OUTER JOIN
                      dbo.UserInfo AS UserInfo_2 ON dbo.ProjectFederalProgramDetail.IDISCompleteBy = UserInfo_2.UserId LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectFederalProgramDetail.FundCompleteBy = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.UserInfo AS UserInfo_1 ON dbo.ProjectFederalProgramDetail.CompleteBy = UserInfo_1.UserId LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_3 ON dbo.ProjectFederalProgramDetail.CHDORecert = LookupValues_3.TypeID RIGHT OUTER JOIN
                      dbo.ProjectFederal INNER JOIN
                      dbo.Project ON dbo.ProjectFederal.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID LEFT OUTER JOIN
                      dbo.FederalUnit ON dbo.ProjectFederal.ProjectFederalID = dbo.FederalUnit.ProjectFederalID LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectFederal.LkFedProg = dbo.LookupValues.TypeID ON 
                      dbo.ProjectFederalProgramDetail.ProjectFederalId = dbo.ProjectFederal.ProjectFederalID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectFederal.RowIsActive = 1) AND (dbo.ProjectFederalProgramDetail.RowIsActive = 1) AND (dbo.ProjectFederal.ProjectID = @ProjID)
END