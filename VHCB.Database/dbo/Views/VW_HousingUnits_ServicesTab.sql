CREATE VIEW dbo.VW_HousingUnits_ServicesTab
AS
SELECT DISTINCT 
                      dbo.Housing.ProjectID, dbo.Project.Proj_num, dbo.VWLK_HousingCategories.Description AS [Housing Category], dbo.Housing.AffordUnits AS [Affordable Units], 
                      dbo.Housing.TotalUnits AS [Total Units], dbo.VWLK_HouseRentalType.Description AS [Rental Type], dbo.VWLK_HouseOwnerType.Description AS [Owner Type], 
                      dbo.ProjectHouseSubType.Units AS [Owner/Rental Units], dbo.VWLK_HouseConstReuseRehab.Description AS [Construction Reuse], 
                      dbo.ProjectHouseConsReuseRehab.LkUnitChar AS [Construction Reuse Units], dbo.VWLK_HouseAccessAdapt.Description AS [Access adapt], 
                      dbo.ProjectHouseAccessAdapt.Numunits AS [Access adapt Units], dbo.VWLK_HouseAgeRestrict.Description AS [Age Restricted], 
                      dbo.ProjectHouseAgeRestrict.Numunits AS [Age Restricted Units], dbo.VWLK_HousePrimaryServices.Description AS [Primary Service], 
                      dbo.ProjectHouseSuppServ.Numunits AS [Primary Service Units], dbo.VWLK_HouseSecondaryServices.Description AS [Seondary Services], 
                      dbo.ProjectHouseSecSuppServ.Numunits AS [Seondary Services Units], dbo.VWLK_HouseVHCBAffordability.Description AS [VHCB Affordability], 
                      dbo.ProjectHouseVHCBAfford.Numunits AS [VHCB Affordability Units], dbo.VWLK_ProjectNames.Description AS [Project Name]
FROM         dbo.VWLK_HouseAgeRestrict INNER JOIN
                      dbo.ProjectHouseAgeRestrict ON dbo.VWLK_HouseAgeRestrict.TypeID = dbo.ProjectHouseAgeRestrict.LKAgeRestrict RIGHT OUTER JOIN
                      dbo.VWLK_ProjectNames RIGHT OUTER JOIN
                      dbo.Housing INNER JOIN
                      dbo.Project ON dbo.Housing.ProjectID = dbo.Project.ProjectId INNER JOIN
                      dbo.ProjectHouseSubType ON dbo.Housing.HousingID = dbo.ProjectHouseSubType.HousingID INNER JOIN
                      dbo.ProjectHouseConsReuseRehab ON dbo.Housing.HousingID = dbo.ProjectHouseConsReuseRehab.HousingID INNER JOIN
                      dbo.VWLK_HousingCategories ON dbo.Housing.LkHouseCat = dbo.VWLK_HousingCategories.TypeID INNER JOIN
                      dbo.VWLK_HouseConstReuseRehab ON dbo.ProjectHouseConsReuseRehab.LkUnitChar = dbo.VWLK_HouseConstReuseRehab.TypeID ON 
                      dbo.VWLK_ProjectNames.ProjectID = dbo.Housing.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_HouseAccessAdapt INNER JOIN
                      dbo.ProjectHouseAccessAdapt ON dbo.VWLK_HouseAccessAdapt.TypeID = dbo.ProjectHouseAccessAdapt.LkUnitChar ON 
                      dbo.Housing.HousingID = dbo.ProjectHouseAccessAdapt.HousingID LEFT OUTER JOIN
                      dbo.VWLK_HouseVHCBAffordability INNER JOIN
                      dbo.ProjectHouseVHCBAfford ON dbo.VWLK_HouseVHCBAffordability.TypeID = dbo.ProjectHouseVHCBAfford.LkAffordunits ON 
                      dbo.Housing.HousingID = dbo.ProjectHouseVHCBAfford.HousingID ON dbo.ProjectHouseAgeRestrict.HousingID = dbo.Housing.HousingID LEFT OUTER JOIN
                      dbo.ProjectHouseSuppServ ON dbo.Housing.HousingID = dbo.ProjectHouseSuppServ.HousingID LEFT OUTER JOIN
                      dbo.VWLK_HouseSecondaryServices INNER JOIN
                      dbo.ProjectHouseSecSuppServ ON dbo.VWLK_HouseSecondaryServices.TypeID = dbo.ProjectHouseSecSuppServ.LKSecSuppServ ON 
                      dbo.Housing.HousingID = dbo.ProjectHouseSecSuppServ.HousingID LEFT OUTER JOIN
                      dbo.VWLK_HousePrimaryServices ON dbo.ProjectHouseSuppServ.LkSuppServ = dbo.VWLK_HousePrimaryServices.TypeID LEFT OUTER JOIN
                      dbo.VWLK_HouseOwnerType ON dbo.ProjectHouseSubType.LkHouseType = dbo.VWLK_HouseOwnerType.TypeID LEFT OUTER JOIN
                      dbo.VWLK_HouseRentalType ON dbo.ProjectHouseSubType.LkHouseType = dbo.VWLK_HouseRentalType.TypeID
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits_ServicesTab';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'   Width = 1500
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
         Alias = 2280
         Table = 3375
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits_ServicesTab';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseAgeRestrict"
            Begin Extent = 
               Top = 114
               Left = 473
               Bottom = 222
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseVHCBAfford"
            Begin Extent = 
               Top = 114
               Left = 692
               Bottom = 222
               Right = 898
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HousingCategories"
            Begin Extent = 
               Top = 255
               Left = 90
               Bottom = 333
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseOwnerType"
            Begin Extent = 
               Top = 237
               Left = 511
               Bottom = 315
               Right = 662
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseRentalType"
            Begin Extent = 
               Top = 328
               Left = 519
               Bottom = 406
               Right = 670
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseConstReuseRehab"
            Begin Extent = 
               Top = 114
               Left = 936
               Bottom = 192
               Right = 1087
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseAccessAdapt"
            Begin Extent = 
               Top = 192
               Left = 936
               Bottom = 270
               Right = 1087
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseAgeRestrict"
            Begin Extent = 
               Top = 222
               Left = 700
               Bottom = 300
               Right = 851
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HousePrimaryServices"
            Begin Extent = 
               Top = 339
               Left = 89
               Bottom = 417
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseSecondaryServices"
            Begin Extent = 
               Top = 240
               Left = 274
               Bottom = 318
               Right = 425
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_HouseVHCBAffordability"
            Begin Extent = 
               Top = 270
               Left = 889
               Bottom = 348
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 270
               Left = 1078
               Bottom = 378
               Right = 1230
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
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits_ServicesTab';


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
         Begin Table = "ProjectHouseSubType"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ProjectHouseConsReuseRehab"
            Begin Extent = 
               Top = 6
               Left = 607
               Bottom = 114
               Right = 847
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseAccessAdapt"
            Begin Extent = 
               Top = 6
               Left = 885
               Bottom = 114
               Right = 1102
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ProjectHouseSuppServ"
            Begin Extent = 
               Top = 142
               Left = 56
               Bottom = 250
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectHouseSecSuppServ"
            Begin Extent = 
               Top = 114
               Left = 247
               Bottom = 222
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_HousingUnits_ServicesTab';

