CREATE VIEW dbo.VWLK_PendingTransactions
AS
SELECT     dbo.Project.Proj_num, dbo.AppName.Applicantname, dbo.Trans.Date, dbo.Fund.name, dbo.Fund.account, dbo.LookupValues.Description, dbo.Detail.Amount, 
                      dbo.Trans.LkStatus
FROM         dbo.ProjectApplicant INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId ON dbo.ProjectApplicant.ProjectId = dbo.Project.ProjectId INNER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ProjectApplicant.ApplicantId = dbo.ApplicantAppName.ApplicantID INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID
WHERE     (dbo.Trans.RowIsActive = 0)
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
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 127
               Left = 222
               Bottom = 235
               Right = 391
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 261
               Left = 24
               Bottom = 369
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 252
               Left = 247
               Bottom = 360
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 138
               Left = 29
               Bottom = 246
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 589
            End
            DisplayFl', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_PendingTransactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_PendingTransactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ags = 280
            TopColumn = 2
         End
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_PendingTransactions';

