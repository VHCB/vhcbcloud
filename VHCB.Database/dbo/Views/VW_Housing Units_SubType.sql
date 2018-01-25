CREATE VIEW dbo.[VW_Housing Units_SubType]
AS
SELECT     dbo.Housing.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      LookupValues_1.Description AS [Housing Category], dbo.LookupValues.Description AS [Housing Subtype], dbo.ProjectHouseSubType.Units, dbo.Housing.Previous, 
                      dbo.Housing.UnitsRemoved, dbo.Housing.NewUnits, dbo.Housing.TotalUnits, dbo.ProjectHouseSubType.HousingTypeID
FROM         dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.ProjectHouseSubType ON dbo.Housing.HousingID = dbo.ProjectHouseSubType.HousingID INNER JOIN
                      dbo.LookupValues ON dbo.ProjectHouseSubType.LkHouseType = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Housing.LkHouseCat = LookupValues_1.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1) AND (dbo.Housing.RowIsActive = 1) AND (dbo.ProjectHouseSubType.RowIsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing Units_SubType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'0
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
         Alias = 2265
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing Units_SubType';


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
         Begin Table = "Housing"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 145
               Left = 340
               Bottom = 253
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseSubType"
            Begin Extent = 
               Top = 6
               Left = 606
               Bottom = 114
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 6
               Left = 797
               Bottom = 114
               Right = 948
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 174
               Left = 12
               Bottom = 282
               Right = 163
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 150', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Housing Units_SubType';

