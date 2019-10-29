CREATE VIEW dbo.VW_RPT_Projdata_Applicant_Address
AS
SELECT     TOP (100) PERCENT dbo.Project.ProjectId, dbo.Project.Proj_num AS [Project #], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.[VWLK_Primary Applicant].[Primary Applicant], dbo.VWLK_Project_Full_Address.Town, dbo.VWLK_Project_Full_Address.County
FROM         dbo.Project INNER JOIN
                      dbo.VW_RPT_ProjectAcres ON dbo.Project.ProjectId = dbo.VW_RPT_ProjectAcres.ProjectId INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID INNER JOIN
                      dbo.[VWLK_Primary Applicant] ON dbo.Project.ProjectId = dbo.[VWLK_Primary Applicant].ProjectId LEFT OUTER JOIN
                      dbo.VWLK_Project_Full_Address ON dbo.Project.ProjectId = dbo.VWLK_Project_Full_Address.ProjectId
WHERE     (dbo.VWLK_ProjectNames.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Projdata_Applicant_Address';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Projdata_Applicant_Address';


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
         Begin Table = "Project"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 133
               Left = 390
               Bottom = 241
               Right = 542
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Primary Applicant"
            Begin Extent = 
               Top = 197
               Left = 19
               Bottom = 275
               Right = 182
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Project_Full_Address"
            Begin Extent = 
               Top = 179
               Left = 208
               Bottom = 287
               Right = 371
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VW_RPT_ProjectAcres"
            Begin Extent = 
               Top = 4
               Left = 561
               Bottom = 112
               Right = 712
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
         Width = 2970
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Projdata_Applicant_Address';

