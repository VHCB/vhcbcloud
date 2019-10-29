CREATE VIEW [dbo].[VW_Committed_LandUsePermit]
AS
SELECT     dbo.Trans.Date, dbo.Detail.LandUsePermitID, dbo.Detail.Amount, dbo.LookupValues.Description AS Type, LookupValues_1.Description AS Status
FROM         dbo.Detail INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkStatus = LookupValues_1.TypeID