CREATE VIEW dbo.VW_ProjectsWithTransactions
AS
SELECT DISTINCT 
                      dbo.Trans.Date, Project_1.Proj_num, dbo.VWLK_FinancialTransactionAction.Description AS [TransAction], 
                      dbo.VWLK_FinancialTransactionType.Description AS TransType, dbo.Fund.name AS Fund, dbo.Detail.Amount, dbo.VWLK_ApplicantName.Applicantname AS Applicant, 
                      dbo.VWLK_ProjectNames.Description AS ProjectName, dbo.VWLK_VHCBPrograms.Description AS Program, dbo.[VW_Applicant Names].Applicantname AS Payee, 
                      dbo.VWLK_FinancialTransStatus.Description AS Status, dbo.Detail.DetailID, dbo.Trans.TransId
FROM         dbo.VWLK_FinancialTransactionAction RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames RIGHT OUTER JOIN
                      dbo.VWLK_FinancialTransStatus INNER JOIN
                      dbo.Project AS Project_1 INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId ON Project_1.ProjectId = dbo.Trans.ProjectID ON 
                      dbo.VWLK_FinancialTransStatus.TypeID = dbo.Trans.LkStatus LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName RIGHT OUTER JOIN
                      dbo.ProjectApplicant ON dbo.VWLK_ApplicantName.ApplicantId = dbo.ProjectApplicant.ApplicantId ON 
                      Project_1.ProjectId = dbo.ProjectApplicant.ProjectId LEFT OUTER JOIN
                      dbo.VWLK_VHCBPrograms ON Project_1.LkProgram = dbo.VWLK_VHCBPrograms.TypeID ON 
                      dbo.VWLK_ProjectNames.ProjectID = Project_1.ProjectId LEFT OUTER JOIN
                      dbo.[VW_Applicant Names] ON dbo.Trans.PayeeApplicant = dbo.[VW_Applicant Names].ApplicantId ON 
                      dbo.VWLK_FinancialTransactionAction.TypeID = dbo.Trans.LkTransaction LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID LEFT OUTER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectsWithTransactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ght = 1129
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 12
               Left = 453
               Bottom = 120
               Right = 622
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 146
               Left = 445
               Bottom = 224
               Right = 596
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VW_Applicant Names"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 10
               Left = 983
               Bottom = 88
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 93
               Left = 789
               Bottom = 201
               Right = 940
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
         Width = 3735
         Width = 2955
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
         Table = 3540
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectsWithTransactions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[51] 4[16] 2[12] 3) )"
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
         Begin Table = "VWLK_FinancialTransactionAction"
            Begin Extent = 
               Top = 6
               Left = 731
               Bottom = 84
               Right = 882
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 152
               Left = 635
               Bottom = 260
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 273
               Left = 57
               Bottom = 351
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project_1"
            Begin Extent = 
               Top = 133
               Left = 237
               Bottom = 241
               Right = 388
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 251
               Bottom = 114
               Right = 402
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 87
               Left = 974
               Bottom = 195
               Ri', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectsWithTransactions';

