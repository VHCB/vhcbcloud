﻿CREATE VIEW dbo.[VW_RPT_Housing VHCBAffordability]
AS
SELECT     dbo.ProjectHouseVHCBAfford.ProjectVHCBAffordUnitsID, dbo.Housing.ProjectID, dbo.Project.Proj_num AS [Project Number], 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Housing.RowIsActive, dbo.ProjectHouseVHCBAfford.Numunits, 
                      dbo.VWLK_AffordUnitsCovenant.Description AS [VHCB Affordability], dbo.ProjectHouseVHCBAfford.RowIsActive AS Expr1, 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName
FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHouseVHCBAfford ON dbo.Housing.HousingID = dbo.ProjectHouseVHCBAfford.HousingID INNER JOIN
                      dbo.VWLK_AffordUnitsCovenant ON dbo.ProjectHouseVHCBAfford.LkAffordunits = dbo.VWLK_AffordUnitsCovenant.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1) AND (dbo.ProjectHouseVHCBAfford.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Housing VHCBAffordability';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N's = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Housing VHCBAffordability';


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
            TopColumn = 13
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseVHCBAfford"
            Begin Extent = 
               Top = 6
               Left = 606
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2745
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidth', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Housing VHCBAffordability';

