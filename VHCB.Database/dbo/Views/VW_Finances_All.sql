CREATE VIEW dbo.VW_Finances_All
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.Detail.DetailID, dbo.VWLK_ProjectNames.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.Trans.Date, dbo.Trans.TransAmt AS [From Trans $$], dbo.VWLK_ApplicantName.Applicantname AS Payee, 
                      dbo.VWLK_FinancialTransactionAction.Description AS [Trans Action], dbo.VWLK_FinancialTransStatus.Description AS Status, Fund_1.name AS Fund, 
                      dbo.VWLK_FinancialTransactionType.Description AS [Trans Type], Detail_1.Amount AS [Detail $$], 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName, dbo.Trans.TransId AS [Transaction ID], 
                      dbo.Fund.name AS [To Fund], Detail_2.Amount AS [To Detail $$], dbo.ReallocateLink.FromTransID
FROM         dbo.VWLK_ProjectNames INNER JOIN
                      dbo.Trans INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId ON dbo.VWLK_ProjectNames.ProjectID = dbo.Trans.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.Trans.PayeeApplicant = dbo.VWLK_ApplicantName.ApplicantId LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionType INNER JOIN
                      dbo.Detail AS Detail_1 ON dbo.VWLK_FinancialTransactionType.TypeID = Detail_1.LkTransType INNER JOIN
                      dbo.Detail AS Detail_2 INNER JOIN
                      dbo.Fund ON Detail_2.FundId = dbo.Fund.FundId ON Detail_1.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.Fund AS Fund_1 ON Detail_1.FundId = Fund_1.FundId RIGHT OUTER JOIN
                      dbo.ReallocateLink ON Detail_2.TransId = dbo.ReallocateLink.ToTransID ON dbo.Trans.TransId = dbo.ReallocateLink.FromTransID AND 
                      dbo.Trans.TransId = Detail_1.TransId LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransStatus ON dbo.Trans.LkStatus = dbo.VWLK_FinancialTransStatus.TypeID LEFT OUTER JOIN
                      dbo.VWLK_FinancialTransactionAction ON dbo.Trans.LkTransaction = dbo.VWLK_FinancialTransactionAction.TypeID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Finances_All';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionType"
            Begin Extent = 
               Top = 252
               Left = 850
               Bottom = 330
               Right = 1001
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ReallocateLink"
            Begin Extent = 
               Top = 186
               Left = 26
               Bottom = 294
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Detail_2"
            Begin Extent = 
               Top = 176
               Left = 563
               Bottom = 284
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 1
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
         Begin Table = "Detail"
            Begin Extent = 
               Top = 90
               Left = 756
               Bottom = 198
               Right = 907
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
      Begin ColumnWidths = 18
         Width = 284
         Width = 1500
         Width = 1500
         Width = 3510
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
         Alias = 2010
         Table = 2925
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Finances_All';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[20] 2[15] 3) )"
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
               Top = 19
               Left = 15
               Bottom = 127
               Right = 188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 306
               Left = 692
               Bottom = 414
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 143
               Left = 344
               Bottom = 251
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransactionAction"
            Begin Extent = 
               Top = 7
               Left = 473
               Bottom = 85
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FinancialTransStatus"
            Begin Extent = 
               Top = 5
               Left = 663
               Bottom = 83
               Right = 814
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail_1"
            Begin Extent = 
               Top = 170
               Left = 1084
               Bottom = 278
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Fund_1"
            Begin Extent = 
               Top = 289
               Left = 260
               Bottom = 397
              ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Finances_All';

