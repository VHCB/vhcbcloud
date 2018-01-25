CREATE VIEW dbo.[VW_Check Request Detail]
AS
SELECT     dbo.Fund.name, dbo.LookupValues.Description, dbo.Detail.Amount, dbo.Detail.TransId, dbo.Fund.account, dbo.StateAccount.StateAcctnum, 
                      LookupValues_2.Description AS Status, dbo.Fund.DeptID, dbo.Fund.VHCBCode
FROM         dbo.Detail INNER JOIN
                      dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
                      dbo.LookupValues ON dbo.Detail.LkTransType = dbo.LookupValues.TypeID INNER JOIN
                      dbo.StateAccount ON dbo.Detail.LkTransType = dbo.StateAccount.LkTransType INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Detail.LkTransType = LookupValues_1.TypeID INNER JOIN
                      dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.Trans.LkStatus = LookupValues_2.TypeID
WHERE     (dbo.Detail.TransId = 10)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Detail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'splayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Detail';


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
         Begin Table = "Fund"
            Begin Extent = 
               Top = 9
               Left = 361
               Bottom = 117
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 139
               Left = 829
               Bottom = 247
               Right = 980
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StateAccount"
            Begin Extent = 
               Top = 158
               Left = 219
               Bottom = 266
               Right = 370
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 182
               Left = 444
               Bottom = 290
               Right = 595
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 214
               Left = 18
               Bottom = 322
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 6
               Left = 605
               Bottom = 114
               Right = 756
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Detail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 185
               Right = 189
            End
            Di', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Check Request Detail';

