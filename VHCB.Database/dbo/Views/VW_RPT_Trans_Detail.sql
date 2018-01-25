CREATE VIEW dbo.VW_RPT_Trans_Detail
AS
SELECT DISTINCT 
                      dbo.Detail.DetailID, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], dbo.Trans.Date, 
                      dbo.Trans.TransAmt AS [Trans $$], dbo.VWLK_ApplicantName.Applicantname AS Payee, dbo.VWLK_FinancialTransactionAction.Description AS [Trans Action], 
                      dbo.VWLK_FinancialTransStatus.Description AS Status, dbo.Fund.name AS Fund, dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], 
                      dbo.Detail.Amount AS [Detail $$], dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName, 
                      dbo.Trans.TransId AS [Transaction ID]
FROM         dbo.Trans INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Trans.ProjectID = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.VWLK_FinancialTransactionAction ON dbo.Trans.LkTransaction = dbo.VWLK_FinancialTransactionAction.TypeID INNER JOIN
                      dbo.VWLK_FinancialTransStatus ON dbo.Trans.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.VWLK_FinancialTransactionType ON dbo.Detail.LkTransType = dbo.VWLK_FinancialTransactionType.TypeID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.Trans.PayeeApplicant = dbo.VWLK_ApplicantName.ApplicantId
WHERE     (dbo.Trans.RowIsActive = 1) AND (dbo.Detail.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Trans_Detail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 162
               Left = 631
               Bottom = 270
               Right = 786
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
      Begin ColumnWidths = 14
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
         Width = 2310
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2445
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Trans_Detail';


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
            TopColumn = 7
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 194
               Left = 911
               Bottom = 302
               Right = 1063
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionAction"
            Begin Extent = 
               Top = 6
               Left = 632
               Bottom = 84
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 6
               Left = 821
               Bottom = 84
               Right = 972
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 146
               Left = 39
               Bottom = 254
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 1010
               Bottom = 114
               Right = 1161
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 220
               Left = 299
               Bottom = 298
          ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Trans_Detail';

