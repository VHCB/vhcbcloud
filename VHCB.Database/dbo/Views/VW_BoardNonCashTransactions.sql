CREATE VIEW dbo.VW_BoardNonCashTransactions
AS
SELECT     TOP (100) PERCENT dbo.Trans.TransId, dbo.Trans.Date, dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS ProjectName, dbo.AppName.Applicantname, 
                      dbo.Trans.LkTransaction, dbo.Detail.LkTransType, dbo.Detail.Amount, dbo.Detail.FundId, dbo.Fund.name AS FundName, 
                      dbo.LookupValues.Description AS Trans_action, LookupValues_1.Description AS TransType, LookupValues_2.Description AS Status, dbo.Trans.TransAmt, 
                      dbo.VWLK_VHCBPrograms.Description AS Program, dbo.Detail.DetailID, dbo.LkFundType.Description
FROM         dbo.Project INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId AND dbo.Detail.RowIsActive = 1 INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Trans.ProjectID = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 ON 
                      dbo.Project.ProjectId = dbo.Trans.ProjectID AND dbo.Trans.RowIsActive = 1 INNER JOIN
                      dbo.ProjectApplicant ON dbo.Trans.ProjectID = dbo.ProjectApplicant.ProjectId AND dbo.ProjectApplicant.LkApplicantRole = 358 INNER JOIN
                      dbo.AppName INNER JOIN
                      dbo.ApplicantAppName ON dbo.AppName.AppNameID = dbo.ApplicantAppName.AppNameID ON 
                      dbo.ProjectApplicant.ApplicantId = dbo.ApplicantAppName.ApplicantID AND dbo.ApplicantAppName.DefName = 1 INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId AND dbo.Fund.RowIsActive = 1 INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Detail.LkTransType = LookupValues_1.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID INNER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.Project.LkProgram = dbo.VWLK_VHCBPrograms.TypeID LEFT OUTER JOIN
                      dbo.LkFundType ON dbo.Fund.LkFundType = dbo.LkFundType.TypeId
WHERE     (dbo.Trans.LkTransaction IN (236, 237, 238, 239))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_BoardNonCashTransactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 114
               Left = 257
               Bottom = 222
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 114
               Left = 446
               Bottom = 222
               Right = 597
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 114
               Left = 818
               Bottom = 222
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 210
               Left = 635
               Bottom = 318
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 235
               Left = 58
               Bottom = 313
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LkFundType"
            Begin Extent = 
               Top = 264
               Left = 282
               Bottom = 372
               Right = 433
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
      Begin ColumnWidths = 17
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
         Filter = 2685
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_BoardNonCashTransactions';


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
         Top = -96
         Left = 0
      End
      Begin Tables = 
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
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 589
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 627
               Bottom = 99
               Right = 778
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 6
               Left = 816
               Bottom = 114
               Right = 985
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 102
               Left = 627
               Bottom = 210
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 219
            End
          ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_BoardNonCashTransactions';

