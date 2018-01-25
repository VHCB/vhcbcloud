﻿CREATE VIEW dbo.VW_RPT_HousingUnits
AS
SELECT     dbo.VWLK_ProjectNames.ProjectID, dbo.VWLK_ProjectNames.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.VWLK_HousingCategories.Description AS [Housing Category], dbo.Housing.Hsqft, dbo.Housing.TotalUnits, dbo.Housing.Previous, dbo.Housing.NewUnits, 
                      dbo.Housing.SASH, dbo.Housing.Vermod, dbo.Housing.ServSuppUnits, dbo.Housing.UnitsRemoved, 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName
FROM         dbo.Housing INNER JOIN
                      dbo.VWLK_HousingCategories ON dbo.Housing.LkHouseCat = dbo.VWLK_HousingCategories.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Housing.ProjectID = dbo.VWLK_ProjectNames.ProjectID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HousingUnits';


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
            TopColumn = 6
         End
         Begin Table = "VWLK_HousingCategories"
            Begin Extent = 
               Top = 6
               Left = 417
               Bottom = 84
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 136
               Left = 15
               Bottom = 244
               Right = 167
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
      Begin ColumnWidths = 16
         Width = 284
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HousingUnits';

