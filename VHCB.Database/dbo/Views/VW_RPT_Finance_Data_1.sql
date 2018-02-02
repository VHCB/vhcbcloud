CREATE VIEW dbo.VW_RPT_Finance_Data
AS
SELECT     dbo.Trans.TransId, dbo.Detail.DetailID, dbo.Trans.Correction, dbo.Trans.Date, dbo.Trans.ProjectID, dbo.VWLK_ProjectNames.Proj_num, 
                      dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Fund.name, dbo.Trans.TransAmt, dbo.VWLK_FinancialTransactionAction.Description AS [Trans Action], 
                      dbo.VWLK_FinancialTransStatus.Description AS [Trans Status], dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], 
                      VWLK_ProjectNames_1.Proj_num AS [To Project #], VWLK_ProjectNames_1.Description AS [To Project Name], dbo.Detail.Amount AS [Detail Amt]
FROM         dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId AND dbo.Detail.RowIsActive = 1 INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Trans.ProjectID = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId AND dbo.Fund.RowIsActive = 1 INNER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames AS VWLK_ProjectNames_1 ON dbo.Detail.ProjectID = VWLK_ProjectNames_1.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransStatus ON dbo.Trans.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionAction ON dbo.Trans.LkTransaction = dbo.VWLK_FinancialTransactionAction.TypeID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Finance_Data';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames_1"
            Begin Extent = 
               Top = 151
               Left = 809
               Bottom = 259
               Right = 961
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Finance_Data';


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
         Top = -480
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 170
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 29
               Left = 571
               Bottom = 137
               Right = 723
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 805
               Bottom = 114
               Right = 956
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionAction"
            Begin Extent = 
               Top = 211
               Left = 323
               Bottom = 285
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 189
               Left = 553
               Bottom = 267
               Right = 704
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 269
               Left = 54
               Bottom = 347
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Finance_Data';

