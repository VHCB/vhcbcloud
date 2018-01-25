CREATE VIEW dbo.VW_HousingUnits
AS
SELECT     TOP (100) PERCENT dbo.Housing.ProjectID, dbo.Housing.HousingID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.VWLK_HousingCategories.Description AS [Housing Category], dbo.Housing.Hsqft, 
                      dbo.Housing.TotalUnits, dbo.Housing.Previous, dbo.Housing.UnitsRemoved, dbo.Housing.NewUnits, dbo.Housing.SASH, dbo.Housing.Vermod, 
                      dbo.Housing.ServSuppUnits, dbo.VWLK_ProjectTypes.Description AS [Project Type], dbo.ProjectHouseVHCBAfford.Numunits AS NotinCovenant
FROM         dbo.VWLK_ProjectTypes RIGHT OUTER JOIN
                      dbo.Project ON dbo.VWLK_ProjectTypes.TypeID = dbo.Project.LkProjectType RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames RIGHT OUTER JOIN
                      dbo.Housing LEFT OUTER JOIN
                      dbo.ProjectHouseVHCBAfford ON dbo.Housing.HousingID = dbo.ProjectHouseVHCBAfford.HousingID AND 
                      dbo.ProjectHouseVHCBAfford.LkAffordunits = 187 LEFT OUTER JOIN
                      dbo.VWLK_HousingCategories ON dbo.Housing.LkHouseCat = dbo.VWLK_HousingCategories.TypeID ON 
                      dbo.VWLK_ProjectNames.ProjectID = dbo.Housing.ProjectID ON dbo.Project.ProjectId = dbo.Housing.ProjectID AND dbo.Project.LkProgram = 144
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'4
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Table = 2835
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits';


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
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 179
               Left = 1029
               Bottom = 287
               Right = 1180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 178
               Left = 28
               Bottom = 286
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HousingCategories"
            Begin Extent = 
               Top = 236
               Left = 213
               Bottom = 314
               Right = 364
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectTypes"
            Begin Extent = 
               Top = 174
               Left = 542
               Bottom = 252
               Right = 693
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseVHCBAfford"
            Begin Extent = 
               Top = 44
               Left = 698
               Bottom = 152
               Right = 904
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 17
         Width = 28', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits';

