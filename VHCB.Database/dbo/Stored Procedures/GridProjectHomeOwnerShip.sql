-- =============================================
-- Author:		<Author,,Dan>
-- Create date: <Create Date,,>
-- =============================================
CREATE PROCEDURE [dbo].[GridProjectHomeOwnerShip]
(
	@ProjID				int) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT     dbo.ProjectHomeOwnership.ProjectHomeOwnershipID, dbo.Project.ProjectId, dbo.HomeOwnership.AddressID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.LkLender.Name AS Lender, dbo.AppName.Applicantname AS Owner, dbo.HomeOwnership.MH, 
                      dbo.HomeOwnership.Condo, dbo.HomeOwnership.SFD, dbo.ProjectHomeOwnership.vhfa, dbo.ProjectHomeOwnership.RDLoan, 
                      dbo.ProjectHomeOwnership.VHCBGrant, dbo.ProjectHomeOwnership.OwnerApprec, dbo.ProjectHomeOwnership.CapImprove, dbo.ProjectHomeOwnership.InitFee, 
                      dbo.ProjectHomeOwnership.ResaleFee, dbo.ProjectHomeOwnership.StewFee, dbo.ProjectHomeOwnership.AssistLoan, dbo.ProjectHomeOwnership.RehabLoan, 
                      dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County
FROM         dbo.LkLender RIGHT OUTER JOIN
                      dbo.HomeOwnership INNER JOIN
                      dbo.ProjectHomeOwnership ON dbo.HomeOwnership.HomeOwnershipID = dbo.ProjectHomeOwnership.HomeOwnershipID INNER JOIN
                      dbo.Project ON dbo.HomeOwnership.ProjectId = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.Address ON dbo.HomeOwnership.AddressID = dbo.Address.AddressId INNER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ProjectHomeOwnership.Owner = dbo.ApplicantAppName.ApplicantID ON dbo.LkLender.LenderId = dbo.ProjectHomeOwnership.LkLender
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.HomeOwnership.RowIsActive = 1) AND (dbo.ProjectHomeOwnership.RowIsActive = 1) AND dbo.Project.ProjectID=@ProjID
END