CREATE VIEW dbo.VW_ReallocteLinkData
AS
SELECT     TOP (100) PERCENT dbo.ReallocateLink.ReallocateGUID, Trans_1.TransId AS FromTransID, dbo.Project.Proj_num AS FromProject, dbo.Trans.TransId AS ToTransID, 
                      Project_1.Proj_num AS ToProject, Trans_1.Date AS FromDate, dbo.Trans.Date AS ToDate, dbo.Detail.FundId AS FromFundID, dbo.Detail.Amount AS FromDetailAmt, 
                      Detail_1.FundId AS ToFundID, Detail_1.Amount AS ToDetailAmt, dbo.ReallocateLink.ReallocateID, Fund_1.name AS ToFundName, dbo.Fund.name AS FromFundName, 
                      dbo.VWLK_ProjectNames.Description AS FromProjectName, VWLK_ProjectNames_1.Description AS ToProjectName, 
                      dbo.VWLK_FinancialTransactionType.Description AS FromTransType, VWLK_FinancialTransactionType_1.Description AS ToTransType, 
                      dbo.VWLK_FinancialTransStatus.Description AS Status, dbo.ReallocateLink.DateModified
FROM         dbo.ReallocateLink INNER JOIN
                      dbo.Trans AS Trans_1 ON dbo.ReallocateLink.FromTransID = Trans_1.TransId INNER JOIN
                      dbo.Project ON Trans_1.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.Trans ON dbo.ReallocateLink.ToTransID = dbo.Trans.TransId INNER JOIN
                      dbo.Project AS Project_1 ON dbo.Trans.ProjectID = Project_1.ProjectId INNER JOIN
                      dbo.Detail ON Trans_1.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Detail AS Detail_1 ON dbo.Trans.TransId = Detail_1.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Fund AS Fund_1 ON Detail_1.FundId = Fund_1.FundId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames AS VWLK_ProjectNames_1 ON dbo.Trans.ProjectID = VWLK_ProjectNames_1.ProjectID INNER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID INNER JOIN
                      dbo.VWLK_FinancialTransactionType AS VWLK_FinancialTransactionType_1 ON Detail_1.LkTransType = VWLK_FinancialTransactionType_1.TypeID INNER JOIN
                      dbo.VWLK_FinancialTransStatus ON Trans_1.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID
ORDER BY dbo.ReallocateLink.DateModified
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocteLinkData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 280
            TopColumn = 2
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 19
               Left = 818
               Bottom = 127
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund_1"
            Begin Extent = 
               Top = 143
               Left = 804
               Bottom = 251
               Right = 955
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 5
               Left = 1035
               Bottom = 113
               Right = 1186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames_1"
            Begin Extent = 
               Top = 165
               Left = 35
               Bottom = 273
               Right = 186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 114
               Left = 993
               Bottom = 192
               Right = 1144
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType_1"
            Begin Extent = 
               Top = 192
               Left = 993
               Bottom = 270
               Right = 1144
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 254
               Left = 287
               Bottom = 332
               Right = 438
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
      Begin ColumnWidths = 20
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1530
         Table = 2685
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocteLinkData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[17] 3) )"
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
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 6
               Left = 231
               Bottom = 114
               Right = 404
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 11
               Left = 431
               Bottom = 119
               Right = 582
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 133
               Left = 240
               Bottom = 241
               Right = 413
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 142
               Left = 440
               Bottom = 250
               Right = 591
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 18
               Left = 615
               Bottom = 126
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 139
               Left = 625
               Bottom = 247
               Right = 776
            End
            DisplayFlags', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocteLinkData';

