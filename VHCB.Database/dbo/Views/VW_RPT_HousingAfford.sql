CREATE VIEW dbo.VW_RPT_HousingAfford
AS
SELECT DISTINCT 
                      dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS ProjectName, dbo.VWLK_AffordUnitsCovenant.Description AS Affordability, 
                      dbo.ProjectHomeAffordUnits.Numunits, dbo.AppName.Applicantname, 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName
FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHomeAffordUnits ON dbo.Housing.HousingID = dbo.ProjectHomeAffordUnits.HousingID INNER JOIN
                      dbo.VWLK_AffordUnitsCovenant ON dbo.ProjectHomeAffordUnits.LkAffordunits = dbo.VWLK_AffordUnitsCovenant.TypeID INNER JOIN
                      dbo.ProjectApplicant ON dbo.Project.ProjectId = dbo.ProjectApplicant.ProjectId INNER JOIN
                      dbo.ApplicantAppName ON dbo.ProjectApplicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID
WHERE     (dbo.ProjectHomeAffordUnits.RowIsActive = 1) AND (dbo.ApplicantAppName.DefName = 1) AND (dbo.AppName.RowIsActive = 1) AND (dbo.ProjectApplicant.Defapp = 1) 
                      AND (dbo.Housing.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HousingAfford';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 474
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 140
               Left = 523
               Bottom = 248
               Right = 676
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HousingAfford';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Housing"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 99
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHomeAffordUnits"
            Begin Extent = 
               Top = 6
               Left = 605
               Bottom = 114
               Right = 812
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "VWLK_AffordUnitsCovenant"
            Begin Extent = 
               Top = 6
               Left = 850
               Bottom = 84
               Right = 1001
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 134
               Left = 39
               Bottom = 242
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 137
               Left = 293
               Bottom = 245
               Right', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HousingAfford';

