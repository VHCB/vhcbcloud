CREATE VIEW dbo.VW_ReallocateToProjects
AS
SELECT     dbo.ReallocateLink.ReallocateID, Trans_1.Date, Project_1.Proj_num AS FromProjNum, dbo.Project.Proj_num AS ToProject, dbo.ReallocateLink.FromProjectId, 
                      dbo.ReallocateLink.FromTransID, dbo.ReallocateLink.ToProjectId, dbo.ReallocateLink.ToTransID, dbo.Detail.Amount AS ToAmt, dbo.ReallocateLink.ReallocateGUID, 
                      dbo.Fund.name AS ToFund, Detail_1.Amount AS FromAmt, Fund_1.name AS FromFund
FROM         dbo.Trans INNER JOIN
                      dbo.ReallocateLink ON dbo.Trans.ProjectID = dbo.ReallocateLink.FromProjectId AND dbo.Trans.TransId = dbo.ReallocateLink.FromTransID INNER JOIN
                      dbo.Trans AS Trans_1 ON dbo.ReallocateLink.ToProjectId = Trans_1.ProjectID AND dbo.ReallocateLink.ToTransID = Trans_1.TransId INNER JOIN
                      dbo.Project AS Project_1 ON dbo.Trans.ProjectID = Project_1.ProjectId INNER JOIN
                      dbo.Project ON Trans_1.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.Detail ON Trans_1.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Detail AS Detail_1 ON dbo.Trans.TransId = Detail_1.TransId INNER JOIN
                      dbo.Fund AS Fund_1 ON Detail_1.FundId = Fund_1.FundId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'80
            TopColumn = 0
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 167
               Left = 698
               Bottom = 275
               Right = 849
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Fund_1"
            Begin Extent = 
               Top = 173
               Left = 921
               Bottom = 281
               Right = 1072
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
         Alias = 1575
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocateToProjects';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocateToProjects';


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
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 186
               Left = 225
               Bottom = 294
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 179
               Left = 428
               Bottom = 287
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 166
               Left = 32
               Bottom = 274
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 15
               Left = 275
               Bottom = 123
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 9
               Left = 638
               Bottom = 117
               Right = 789
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 31
               Left = 865
               Bottom = 139
               Right = 1016
            End
            DisplayFlags = 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ReallocateToProjects';

