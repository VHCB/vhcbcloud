CREATE VIEW dbo.VW_RPT_AllProjectFinancial
AS
SELECT     dbo.VW_RPT_BasicProjectFinancial.ProjectId, dbo.VW_RPT_BasicProjectFinancial.Proj_num, dbo.VW_RPT_BasicProjectFinancial.Amount, 
                      dbo.LookupValues.Description AS ProjectType, dbo.VW_RPT_BasicProjectFinancial.TransId, dbo.VW_RPT_BasicProjectFinancial.Date, 
                      dbo.VW_RPT_BasicProjectFinancial.DetailID, dbo.VW_RPT_BasicProjectFinancial.[Fund Name], dbo.VW_RPT_BasicProjectFinancial.abbrv, 
                      dbo.VW_RPT_BasicProjectFinancial.[Fund Group], dbo.VW_RPT_BasicProjectFinancial.TransAmt, dbo.VW_RPT_BasicProjectFinancial.[Fund Source], 
                      LookupValues_1.Description AS [Trans Action], LookupValues_2.Description AS Status, LookupValues_3.Description AS [Trans Type], 
                      dbo.VW_RPT_BasicProjectFinancial.[Project Name], dbo.Address.Town, dbo.Address.County, dbo.VW_RPT_BasicProjectFinancial.[Conserve Goal], 
                      dbo.VW_RPT_BasicProjectFinancial.Program, dbo.VW_RPT_BasicProjectFinancial.[Primary Applicant]
FROM         dbo.Address INNER JOIN
                      dbo.ProjectAddress ON dbo.Address.AddressId = dbo.ProjectAddress.AddressId RIGHT OUTER JOIN
                      dbo.VW_RPT_BasicProjectFinancial ON dbo.ProjectAddress.ProjectId = dbo.VW_RPT_BasicProjectFinancial.ProjectId AND dbo.ProjectAddress.RowIsActive = 1 AND 
                      dbo.ProjectAddress.PrimaryAdd = 1 LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_3 ON dbo.VW_RPT_BasicProjectFinancial.LkTransType = LookupValues_3.TypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_2 ON dbo.VW_RPT_BasicProjectFinancial.LkStatus = LookupValues_2.TypeID AND 
                      LookupValues_2.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.VW_RPT_BasicProjectFinancial.LkProjectType = dbo.LookupValues.TypeID AND dbo.LookupValues.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.VW_RPT_BasicProjectFinancial.LkTransaction = LookupValues_1.TypeID AND LookupValues_1.RowIsActive = 1
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
         Begin Table = "Address"
            Begin Extent = 
               Top = 31
               Left = 1001
               Bottom = 139
               Right = 1154
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "ProjectAddress"
            Begin Extent = 
               Top = 6
               Left = 547
               Bottom = 114
               Right = 710
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues_3"
            Begin Extent = 
               Top = 126
               Left = 654
               Bottom = 234
               Right = 805
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_2"
            Begin Extent = 
               Top = 135
               Left = 246
               Bottom = 243
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 179
               Left = 429
               Bottom = 287
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 236
               Left = 33
               Bottom = 344
               Right = 184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VW_RPT_BasicProjectFinancial"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_AllProjectFinancial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_AllProjectFinancial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 189
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
      Begin ColumnWidths = 22
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_AllProjectFinancial';

