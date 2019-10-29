CREATE VIEW dbo.VW_RPT_FinancialData
AS
SELECT     dbo.Trans.TransId, dbo.Detail.DetailID, dbo.Trans.Date AS [Trans Date], dbo.Trans.TransAmt AS [Trans $$], dbo.LookupValues.Description AS [Trans Action], 
                      LookupValues_1.Description AS Status, dbo.Fund.name AS [Fund Name], dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], 
                      dbo.Detail.Amount AS [Detail $$], dbo.LkFundType.Description AS [Fund Type], LookupValues_2.Description AS [Source of Funds], dbo.Project.ProjectId, 
                      dbo.Project.Proj_num
FROM         dbo.LookupValues RIGHT OUTER JOIN
                      dbo.Project LEFT OUTER JOIN
                      dbo.Trans ON dbo.Project.ProjectId = dbo.Trans.ProjectID AND dbo.Trans.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Trans.LkStatus = LookupValues_1.TypeID ON dbo.LookupValues.TypeID = dbo.Trans.LkTransaction LEFT OUTER JOIN
                      dbo.Fund LEFT OUTER JOIN
                      dbo.Detail ON dbo.Fund.FundId = dbo.Detail.FundId AND dbo.Detail.RowIsActive = 1 AND dbo.Fund.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 RIGHT OUTER JOIN
                      dbo.LkFundType ON LookupValues_2.TypeID = dbo.LkFundType.LkSource ON dbo.Fund.LkFundType = dbo.LkFundType.TypeId AND 
                      dbo.LkFundType.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID ON dbo.Trans.TransId = dbo.Detail.TransId AND 
                      dbo.Detail.RowIsActive = 1
WHERE     (dbo.Project.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_FinancialData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'playFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 190
               Left = 994
               Bottom = 298
               Right = 1145
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 6
               Left = 816
               Bottom = 84
               Right = 967
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
      Begin ColumnWidths = 15
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_FinancialData';


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
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 66
               Left = 437
               Bottom = 174
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 0
               Left = 14
               Bottom = 108
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 9
               Left = 206
               Bottom = 117
               Right = 379
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 0
               Left = 606
               Bottom = 108
               Right = 757
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 176
               Left = 69
               Bottom = 284
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 221
               Left = 687
               Bottom = 329
               Right = 838
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkFundType"
            Begin Extent = 
               Top = 210
               Left = 305
               Bottom = 318
               Right = 456
            End
            Dis', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_FinancialData';

