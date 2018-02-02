CREATE VIEW dbo.VW_Reallocation_OtherProjects
AS
SELECT     dbo.ReallocateLink.FromProjectId, Project_1.Proj_num, dbo.VWLK_ProjectNames.Description, dbo.ReallocateLink.ToProjectId, dbo.Project.Proj_num AS To_Project, 
                      VWLK_ProjectNames_1.Description AS To_ProjectName, dbo.Detail.Amount, Detail_1.Amount AS Expr4, dbo.ReallocateLink.CommonTrans
FROM         dbo.VWLK_ProjectNames AS VWLK_ProjectNames_1 INNER JOIN
                      dbo.Project INNER JOIN
                      dbo.ReallocateLink INNER JOIN
                      dbo.Project AS Project_1 ON dbo.ReallocateLink.FromProjectId = Project_1.ProjectId ON dbo.Project.ProjectId = dbo.ReallocateLink.ToProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON Project_1.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON VWLK_ProjectNames_1.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.Trans ON dbo.ReallocateLink.FromTransID = dbo.Trans.TransId INNER JOIN
                      dbo.Trans AS Trans_1 ON dbo.ReallocateLink.ToTransID = Trans_1.TransId INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Detail AS Detail_1 ON Trans_1.TransId = Detail_1.TransId
WHERE     (dbo.ReallocateLink.FromProjectId <> dbo.ReallocateLink.ToProjectId)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Reallocation_OtherProjects';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 6
               Left = 818
               Bottom = 114
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 5
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Reallocation_OtherProjects';


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
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 6
               Left = 231
               Bottom = 114
               Right = 382
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 180
               Left = 246
               Bottom = 288
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 7
               Left = 440
               Bottom = 100
               Right = 591
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames_1"
            Begin Extent = 
               Top = 175
               Left = 580
               Bottom = 268
               Right = 731
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 160
               Left = 19
               Bottom = 268
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 183
               Left = 780
               Bottom = 291
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 629
               Bottom = 114
               Right = 780
            End
          ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Reallocation_OtherProjects';

