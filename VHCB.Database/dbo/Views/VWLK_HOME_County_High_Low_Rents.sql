CREATE VIEW dbo.VWLK_HOME_County_High_Low_Rents
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.VWLK_County.Description AS County, dbo.CountyUnitRents.HighRent, dbo.CountyUnitRents.LowRent, 
                      dbo.VWLK_FederalUnitSize.Description AS Bedrooms
FROM         dbo.CountyUnitRents INNER JOIN
                      dbo.CountyRents ON dbo.CountyUnitRents.CountyRentID = dbo.CountyRents.CountyRentId INNER JOIN
                      dbo.VWLK_FedProgs ON dbo.CountyRents.FedProgID = dbo.VWLK_FedProgs.TypeID INNER JOIN
                      dbo.VWLK_County ON dbo.CountyRents.County = dbo.VWLK_County.TypeID INNER JOIN
                      dbo.VWLK_FederalUnitSize ON dbo.CountyUnitRents.UnitType = dbo.VWLK_FederalUnitSize.TypeID
WHERE     (dbo.VWLK_FedProgs.TypeID = 481) AND (dbo.CountyUnitRents.RowIsActive = 1) AND (dbo.CountyRents.RowIsActive = 1)
ORDER BY County, Bedrooms
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
         Begin Table = "CountyUnitRents"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "CountyRents"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 114
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "VWLK_FedProgs"
            Begin Extent = 
               Top = 6
               Left = 433
               Bottom = 84
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_County"
            Begin Extent = 
               Top = 151
               Left = 349
               Bottom = 229
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_FederalUnitSize"
            Begin Extent = 
               Top = 158
               Left = 21
               Bottom = 236
               Right = 172
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
      Begin ColumnWidths = 9
         Width = 284
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
         Column = 1440', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_HOME_County_High_Low_Rents';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_HOME_County_High_Low_Rents';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VWLK_HOME_County_High_Low_Rents';

