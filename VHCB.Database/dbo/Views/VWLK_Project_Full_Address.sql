﻿CREATE VIEW dbo.VWLK_Project_Full_Address
AS
SELECT     dbo.Project.Proj_num AS [Project Number], dbo.Project.ProjectId, dbo.VWLK_AddressType.Description AS [Address Type], dbo.Address.Street#, dbo.Address.Address1, 
                      dbo.Address.Address2, dbo.Address.Village, dbo.Address.Town, dbo.Address.State, dbo.Address.Zip, dbo.Address.County, dbo.ProjectAddress.ProjectaddressID
FROM         dbo.ProjectAddress INNER JOIN
                      dbo.Address ON dbo.ProjectAddress.PrimaryAdd = 1 AND dbo.ProjectAddress.AddressId = dbo.Address.AddressId INNER JOIN
                      dbo.VWLK_AddressType ON dbo.Address.LkAddressType = dbo.VWLK_AddressType.TypeID RIGHT OUTER JOIN
                      dbo.Project ON dbo.ProjectAddress.ProjectId = dbo.Project.ProjectId
WHERE     (dbo.ProjectAddress.PrimaryAdd = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_Project_Full_Address';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_Project_Full_Address';


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
         Begin Table = "ProjectAddress"
            Begin Extent = 
               Top = 9
               Left = 225
               Bottom = 117
               Right = 388
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Address"
            Begin Extent = 
               Top = 3
               Left = 536
               Bottom = 111
               Right = 689
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_AddressType"
            Begin Extent = 
               Top = 6
               Left = 727
               Bottom = 84
               Right = 878
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 9
               Left = 46
               Bottom = 117
               Right = 197
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
         SortOrder = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_Project_Full_Address';

