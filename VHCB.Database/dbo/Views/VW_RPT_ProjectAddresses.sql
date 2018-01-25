CREATE VIEW dbo.VW_RPT_ProjectAddresses
AS
SELECT     dbo.ProjectAddress.ProjectaddressID, dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.ProjectAddress.PrimaryAdd, dbo.VWLK_AddressType.Description AS [Address Type], dbo.Address.Street#, dbo.Address.Address1, dbo.Address.Address2, 
                      dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County, 
                      dbo.VWLK_ProjectNames.Proj_num + '  ' + dbo.VWLK_ProjectNames.Description AS ProjectNumberName
FROM         dbo.Address INNER JOIN
                      dbo.ProjectAddress ON dbo.Address.AddressId = dbo.ProjectAddress.AddressId INNER JOIN
                      dbo.VWLK_AddressType ON dbo.Address.LkAddressType = dbo.VWLK_AddressType.TypeID RIGHT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID ON dbo.ProjectAddress.ProjectId = dbo.Project.ProjectId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.ProjectAddress.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectAddresses';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'dth = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectAddresses';


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
               Top = 140
               Left = 277
               Bottom = 248
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectAddress"
            Begin Extent = 
               Top = 148
               Left = 32
               Bottom = 256
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "VWLK_AddressType"
            Begin Extent = 
               Top = 146
               Left = 508
               Bottom = 224
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 0
         End
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
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 6
               Left = 428
               Bottom = 114
               Right = 580
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
         Width = 1500
         Wi', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectAddresses';

