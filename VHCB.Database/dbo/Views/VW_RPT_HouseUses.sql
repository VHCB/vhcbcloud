CREATE VIEW dbo.VW_RPT_HouseUses
AS
SELECT DISTINCT 
                      dbo.Housing.ProjectID, dbo.HouseUse.HouseUseID, dbo.VWLK_BudgetPeriod.Description AS [Budget Period], dbo.VWLK_HouseUses.Description AS [VHCB Uses], 
                      dbo.HouseUse.VHCBTotal, dbo.VWLK_ProjectNames.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      VWLK_HouseUses_1.Description AS [Uses Other], dbo.HouseUse.OtherTotal, dbo.HouseSU.DateModified, 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName
FROM         dbo.VWLK_ProjectNames RIGHT OUTER JOIN
                      dbo.Housing ON dbo.VWLK_ProjectNames.ProjectID = dbo.Housing.ProjectID RIGHT OUTER JOIN
                      dbo.VWLK_BudgetPeriod RIGHT OUTER JOIN
                      dbo.HouseUse INNER JOIN
                      dbo.HouseSU ON dbo.HouseUse.HouseSUID = dbo.HouseSU.HouseSUID LEFT OUTER JOIN
                      dbo.VWLK_HouseUses AS VWLK_HouseUses_1 ON dbo.HouseUse.LKHouseUseOther = VWLK_HouseUses_1.TypeID LEFT OUTER JOIN
                      dbo.VWLK_HouseUses ON dbo.HouseUse.LkHouseUseVHCB = dbo.VWLK_HouseUses.TypeID ON 
                      dbo.VWLK_BudgetPeriod.TypeID = dbo.HouseSU.LkBudgetPeriod ON dbo.Housing.HousingID = dbo.HouseSU.HousingId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HouseUses';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 2115
         Width = 1500
         Width = 1500
         Width = 2100
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HouseUses';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[24] 3) )"
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
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 146
               Left = 73
               Bottom = 254
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Housing"
            Begin Extent = 
               Top = 7
               Left = 50
               Bottom = 115
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_BudgetPeriod"
            Begin Extent = 
               Top = 6
               Left = 435
               Bottom = 84
               Right = 586
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HouseUse"
            Begin Extent = 
               Top = 168
               Left = 408
               Bottom = 276
               Right = 575
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HouseSU"
            Begin Extent = 
               Top = 6
               Left = 243
               Bottom = 114
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseUses_1"
            Begin Extent = 
               Top = 6
               Left = 813
               Bottom = 84
               Right = 964
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseUses"
            Begin Extent = 
               Top = 6
               Left = 624
               Bottom = 84
               Right = 775
            End
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_HouseUses';

