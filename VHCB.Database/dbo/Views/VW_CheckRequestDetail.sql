CREATE VIEW dbo.VW_CheckRequestDetail
AS
SELECT     dbo.Trans.TransId, dbo.Trans.Date, dbo.Trans.TransAmt, dbo.LookupValues.Description AS [TransAction], dbo.Trans.ProjectCheckReqID, dbo.Detail.LkTransType, 
                      LookupValues_1.Description AS TransType, dbo.Detail.Amount, dbo.Detail.LandUsePermitID, dbo.Fund.name AS [Fund Name], dbo.StateAccount.StateAcctnum, 
                      dbo.Fund.account, dbo.Fund.DeptID, dbo.Fund.VHCBCode, dbo.Act250Farm.UsePermit
FROM         dbo.Trans INNER JOIN
                      dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID INNER JOIN
                      dbo.Detail ON dbo.Trans.TransId = dbo.Detail.TransId INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Detail.LkTransType = LookupValues_1.TypeID INNER JOIN
                      dbo.StateAccount ON dbo.Detail.LkTransType = dbo.StateAccount.LkTransType LEFT OUTER JOIN
                      dbo.Act250Farm ON dbo.Detail.LandUsePermitID = dbo.Act250Farm.Act250FarmID
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
            TopColumn = 2
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 137
               Left = 42
               Bottom = 245
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Fund"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 589
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 129
               Left = 247
               Bottom = 237
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StateAccount"
            Begin Extent = 
               Top = 6
               Left = 627
               Bottom = 114
               Right = 778
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Act250Farm"
            Begin Extent = 
               Top = 182
               Left = 718
               Bottom = 290
               Right = 869
            End
            DisplayF', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestDetail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestDetail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'lags = 280
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
         Column = 2730
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_CheckRequestDetail';

