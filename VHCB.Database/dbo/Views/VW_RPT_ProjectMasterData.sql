CREATE VIEW dbo.VW_RPT_ProjectMasterData
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.Project.ProjectId, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.LookupValues.Description AS [Project Type], LookupValues_1.Description AS [VHCB Program], dbo.VWLK_ApplicantName.Applicantname, dbo.Project.ClosingDate, 
                      LookupValues_3.Description AS [Conservation Goal], dbo.Housing.NewUnits, dbo.Housing.UnitsRemoved, dbo.Conserve.TotalAcres, 
                      VWLK_ProjectTownCountyZip_1.Town, VWLK_ProjectTownCountyZip_1.County, VWLK_ProjectTownCountyZip_1.Zip, dbo.VWLK_ApplicantName.ApplicantAbbrv, 
                      dbo.Trans.Date
FROM         dbo.VWLK_ProjectTownCountyZip AS VWLK_ProjectTownCountyZip_1 RIGHT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.LookupValues ON dbo.Project.LkProjectType = dbo.LookupValues.TypeID INNER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Project.LkProgram = LookupValues_1.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 ON 
                      VWLK_ProjectTownCountyZip_1.ProjectId = dbo.Project.ProjectId AND dbo.Project.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.Trans ON dbo.Project.ProjectId = dbo.Trans.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_ApplicantName ON dbo.Project.ProjectId = dbo.VWLK_ApplicantName.ProjectId AND dbo.VWLK_ApplicantName.LkApplicantRole = 358 LEFT OUTER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID AND dbo.Conserve.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.Housing ON dbo.Project.ProjectId = dbo.Housing.ProjectID AND dbo.Housing.RowIsActive = 1 LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_3 ON dbo.Project.Goal = LookupValues_3.TypeID
WHERE     (VWLK_ProjectTownCountyZip_1.PrimaryAdd = 1)
ORDER BY dbo.Trans.Date DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMasterData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ht = 370
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Conserve"
            Begin Extent = 
               Top = 198
               Left = 825
               Bottom = 306
               Right = 976
            End
            DisplayFlags = 280
            TopColumn = 22
         End
         Begin Table = "Housing"
            Begin Extent = 
               Top = 172
               Left = 636
               Bottom = 280
               Right = 787
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "LookupValues_3"
            Begin Extent = 
               Top = 88
               Left = 951
               Bottom = 196
               Right = 1102
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
      Begin ColumnWidths = 19
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 2550
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMasterData';


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
         Top = -154
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VWLK_ProjectTownCountyZip_1"
            Begin Extent = 
               Top = 397
               Left = 83
               Bottom = 505
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Project"
            Begin Extent = 
               Top = 20
               Left = 8
               Bottom = 128
               Right = 159
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 336
               Left = 618
               Bottom = 444
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 42
               Left = 415
               Bottom = 150
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 63
               Left = 249
               Bottom = 171
               Right = 401
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 198
               Left = 1030
               Bottom = 306
               Right = 1203
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "VWLK_ApplicantName"
            Begin Extent = 
               Top = 170
               Left = 215
               Bottom = 278
               Rig', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_ProjectMasterData';

