CREATE VIEW dbo.AAAAReallocations
AS
SELECT DISTINCT 
                      Trans_1.TransId AS [From Trans], dbo.Project.Proj_num AS [From Proj], dbo.Fund.name AS [From Fund], Detail_1.Amount AS [From Amount], 
                      LookupValues_1.Description AS [From Type], Trans_2.TransId AS [To Trans], Project_1.Proj_num AS [To Proj], Fund_1.name AS [To Fund], 
                      Detail_2.Amount AS [To Amount], dbo.LookupValues.Description AS [To Type], Trans_1.Date
FROM         dbo.LookupValues INNER JOIN
                      dbo.Detail AS Detail_1 INNER JOIN
                      dbo.Trans AS Trans_1 INNER JOIN
                      dbo.ReallocateLink ON Trans_1.TransId = dbo.ReallocateLink.FromTransID INNER JOIN
                      dbo.Trans AS Trans_2 ON dbo.ReallocateLink.ToTransID = Trans_2.TransId ON Detail_1.TransId = Trans_1.TransId INNER JOIN
                      dbo.Detail AS Detail_2 ON Trans_2.TransId = Detail_2.TransId INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON Detail_1.LkTransType = LookupValues_1.TypeID ON dbo.LookupValues.TypeID = Detail_2.LkTransType INNER JOIN
                      dbo.Project AS Project_1 ON Trans_2.ProjectID = Project_1.ProjectId INNER JOIN
                      dbo.Project ON Trans_1.ProjectID = dbo.Project.ProjectId AND Project_1.Proj_num <> dbo.Project.Proj_num INNER JOIN
                      dbo.Fund ON Detail_1.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Fund AS Fund_1 ON Detail_2.FundId = Fund_1.FundId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[16] 2[20] 3) )"
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
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 6
               Left = 627
               Bottom = 114
               Right = 778
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 161
               Left = 248
               Bottom = 269
               Right = 399
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Trans_1"
            Begin Extent = 
               Top = 190
               Left = 28
               Bottom = 298
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 4
               Left = 25
               Bottom = 112
               Right = 176
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans_2"
            Begin Extent = 
               Top = 16
               Left = 415
               Bottom = 124
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail_2"
            Begin Extent = 
               Top = 135
               Left = 628
               Bottom = 243
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 8
               Left = 223
               Bottom = 116
               Right = 374
            End
          ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AAAAReallocations';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AAAAReallocations';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 152
               Left = 426
               Bottom = 260
               Right = 577
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 286
               Left = 216
               Bottom = 394
               Right = 367
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 280
               Left = 417
               Bottom = 388
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund_1"
            Begin Extent = 
               Top = 309
               Left = 618
               Bottom = 417
               Right = 769
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
      Begin ColumnWidths = 12
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 2220
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AAAAReallocations';

