CREATE VIEW dbo.VW_ConservationSourceandUse
AS
SELECT DISTINCT 
                      dbo.Project.Proj_num, dbo.Conserve.ProjectID, dbo.LookupValues.Description AS Source, dbo.ConserveSources.Total AS SourceTotal, 
                      LookupValues_1.Description AS Uses, dbo.ConserveUses.VHCBTotal AS VHCBTotalUse, LookupValues_2.Description AS BudgetPeriod, 
                      LookupValues_3.Description AS UseOther, dbo.ConserveUses.OtherTotal
FROM         dbo.Conserve INNER JOIN
                      dbo.LookupValues AS LookupValues_2 INNER JOIN
                      dbo.ConserveSources INNER JOIN
                      dbo.ConserveSU ON dbo.ConserveSources.ConserveSUID = dbo.ConserveSU.ConserveSUID INNER JOIN
                      dbo.LookupValues ON dbo.ConserveSources.LkConSource = dbo.LookupValues.TypeID ON LookupValues_2.TypeID = dbo.ConserveSU.LKBudgetPeriod ON 
                      dbo.Conserve.ConserveID = dbo.ConserveSU.ConserveID INNER JOIN
                      dbo.Project ON dbo.Conserve.ProjectID = dbo.Project.ProjectId CROSS JOIN
                      dbo.LookupValues AS LookupValues_3 INNER JOIN
                      dbo.LookupValues AS LookupValues_1 INNER JOIN
                      dbo.ConserveUses ON LookupValues_1.TypeID = dbo.ConserveUses.LkConUseVHCB ON LookupValues_3.TypeID = dbo.ConserveUses.LkConUseOther
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
         Begin Table = "ConserveSources"
            Begin Extent = 
               Top = 148
               Left = 162
               Bottom = 256
               Right = 337
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ConserveUses"
            Begin Extent = 
               Top = 154
               Left = 379
               Bottom = 262
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ConserveSU"
            Begin Extent = 
               Top = 13
               Left = 453
               Bottom = 121
               Right = 608
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 285
               Left = 147
               Bottom = 393
               Right = 298
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 266
               Left = 310
               Bottom = 374
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 262
               Left = 510
               Bottom = 370
               Right = 661
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_3"
            Begin Extent = 
               Top = 258
               Left = 717
               Bottom = 366
               Right = 868
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ConservationSourceandUse';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ConservationSourceandUse';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Conserve"
            Begin Extent = 
               Top = 21
               Left = 258
               Bottom = 129
               Right = 409
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ConservationSourceandUse';

