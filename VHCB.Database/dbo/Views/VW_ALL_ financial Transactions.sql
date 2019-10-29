CREATE VIEW dbo.[VW_ALL_ financial Transactions]
AS
SELECT DISTINCT 
                      dbo.Trans.TransId, dbo.Detail.DetailID, dbo.Trans.ProjectID, dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Trans.Date, dbo.Trans.TransAmt, 
                      dbo.Trans.PayeeApplicant, dbo.Detail.FundId, dbo.Detail.Amount, dbo.Trans.ProjectCheckReqID, dbo.Project.Proj_num, dbo.AppName.Applicantname AS Payee, 
                      dbo.VWLK_ApplicantName.Applicantname, dbo.VWLK_FinancialTransactionAction.Description AS [Transaction], 
                      dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], dbo.VWLK_FinancialTransStatus.Description AS Status, dbo.Fund.name AS [Fund Name], 
                      Detail_1.Amount AS [Reall amt], dbo.[VW TransReallocte].Amount AS [Reall Trans Amt], Project_1.Proj_num AS [To Project], Project_2.Proj_num AS [From Project], 
                      dbo.Detail.DateModified, dbo.Project.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS [Project Number-Name]
FROM         dbo.Project AS Project_2 INNER JOIN
                      dbo.Project AS Project_1 INNER JOIN
                      dbo.Detail AS Detail_1 INNER JOIN
                      dbo.[VW TransReallocte] ON Detail_1.TransId = dbo.[VW TransReallocte].[To Trans] ON Project_1.ProjectId = dbo.[VW TransReallocte].[To Project] ON 
                      Project_2.ProjectId = dbo.[VW TransReallocte].[From Project] RIGHT OUTER JOIN
                      dbo.VWLK_FinancialTransactionAction INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_ApplicantName ON dbo.Project.ProjectId = dbo.VWLK_ApplicantName.ProjectId ON 
                      dbo.VWLK_FinancialTransactionAction.TypeID = dbo.Trans.LkTransaction ON dbo.[VW TransReallocte].[From Trans] = dbo.Trans.TransId RIGHT OUTER JOIN
                      dbo.Fund INNER JOIN
                      dbo.VWLK_FinancialTransactionType INNER JOIN
                      dbo.Detail ON dbo.VWLK_FinancialTransactionType.TypeID = dbo.Detail.LkTransType ON dbo.Fund.FundId = dbo.Detail.FundId ON 
                      dbo.Trans.TransId = dbo.Detail.TransId LEFT OUTER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.Trans.PayeeApplicant = dbo.ApplicantAppName.ApplicantID LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransStatus ON dbo.Trans.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ALL_ financial Transactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 1037
               Bottom = 114
               Right = 1188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 126
               Left = 958
               Bottom = 234
               Right = 1109
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 271
               Left = 951
               Bottom = 349
               Right = 1102
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 659
               Bottom = 114
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 6
               Left = 229
               Bottom = 114
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 133
               Left = 613
               Bottom = 211
               Right = 764
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
      Begin ColumnWidths = 24
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2580
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ALL_ financial Transactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[11] 2[20] 3) )"
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
         Begin Table = "Project_2"
            Begin Extent = 
               Top = 270
               Left = 620
               Bottom = 378
               Right = 771
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 262
               Left = 58
               Bottom = 370
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 231
               Left = 434
               Bottom = 339
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VW TransReallocte"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionAction"
            Begin Extent = 
               Top = 114
               Left = 229
               Bottom = 192
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 448
               Bottom = 114
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 848
               Bottom = 114
               Right = 999
            ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ALL_ financial Transactions';

