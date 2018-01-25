CREATE VIEW dbo.VW_RPT_TransAssign
AS
SELECT     dbo.Detail.DetailID, dbo.Project.Proj_num AS [To Project], VWLK_ProjectNames_1.Description AS [To PR Name], dbo.Detail.Amount, dbo.Fund.name AS Fund, 
                      dbo.LookupValues.Description AS TransType, Project_1.Proj_num AS [From Project], dbo.VWLK_ProjectNames.Description AS [From PR Name], dbo.Trans.Date, 
                      Trans_1.TransId AS [From TransID]
FROM         dbo.Project AS Project_1 INNER JOIN
                      dbo.Trans AS Trans_1 ON Project_1.ProjectId = Trans_1.ProjectID INNER JOIN
                      dbo.Detail INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
                      dbo.Project ON dbo.Detail.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.TransAssign ON dbo.Trans.TransId = dbo.TransAssign.ToTransID ON Trans_1.TransId = dbo.TransAssign.TransID INNER JOIN
                      dbo.VWLK_ProjectNames ON Project_1.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_ProjectNames AS VWLK_ProjectNames_1 ON dbo.Project.ProjectId = VWLK_ProjectNames_1.ProjectID INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID
WHERE     (dbo.Trans.LkTransaction = 26552) AND (VWLK_ProjectNames_1.DefName = 1) AND (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_TransAssign';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'gs = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames_1"
            Begin Extent = 
               Top = 198
               Left = 227
               Bottom = 306
               Right = 379
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 114
               Left = 417
               Bottom = 222
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 245
               Left = 413
               Bottom = 353
               Right = 564
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
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_TransAssign';


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
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 238
               Bottom = 114
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 165
               Left = 41
               Bottom = 273
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TransAssign"
            Begin Extent = 
               Top = 6
               Left = 449
               Bottom = 114
               Right = 600
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 6
               Left = 638
               Bottom = 114
               Right = 811
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 6
               Left = 849
               Bottom = 114
               Right = 1000
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 1038
               Bottom = 114
               Right = 1190
            End
            DisplayFla', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_TransAssign';

