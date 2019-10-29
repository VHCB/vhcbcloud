CREATE VIEW dbo.VW_Project_Demographics
AS
SELECT     dbo.Project.ProjectId, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.[VWLK_Primary Applicant].[Primary Applicant], LookupValues_1.Description AS [Project Type], dbo.VWLK_Project_Full_Address.Town, 
                      dbo.VWLK_Project_Full_Address.County, dbo.Conserve.TotalAcres, dbo.Housing.TotalUnits, dbo.LookupValues.Description AS Goal, dbo.Trans.LkTransaction
FROM         dbo.Project LEFT OUTER JOIN
                      dbo.Trans ON dbo.Project.ProjectId = dbo.Trans.ProjectID LEFT OUTER JOIN
                      dbo.[VWLK_Primary Applicant] ON dbo.Project.ProjectId = dbo.[VWLK_Primary Applicant].ProjectId LEFT OUTER JOIN
                      dbo.LookupValues ON dbo.Project.Goal = dbo.LookupValues.TypeID LEFT OUTER JOIN
                      dbo.LookupValues AS LookupValues_1 ON dbo.Project.LkProjectType = LookupValues_1.TypeID LEFT OUTER JOIN
                      dbo.Housing ON dbo.Project.ProjectId = dbo.Housing.ProjectID LEFT OUTER JOIN
                      dbo.Conserve ON dbo.Project.ProjectId = dbo.Conserve.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID LEFT OUTER JOIN
                      dbo.VWLK_Project_Full_Address ON dbo.Project.ProjectId = dbo.VWLK_Project_Full_Address.ProjectId
WHERE     (dbo.Trans.LkTransaction = 238) OR
                      (dbo.Trans.LkTransaction = 240)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_Demographics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Primary Applicant"
            Begin Extent = 
               Top = 12
               Left = 603
               Bottom = 90
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Trans"
            Begin Extent = 
               Top = 278
               Left = 568
               Bottom = 386
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 7
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_Demographics';


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
            TopColumn = 5
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 124
               Left = 203
               Bottom = 232
               Right = 355
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Project_Full_Address"
            Begin Extent = 
               Top = 128
               Left = 415
               Bottom = 236
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Conserve"
            Begin Extent = 
               Top = 107
               Left = 639
               Bottom = 215
               Right = 790
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Housing"
            Begin Extent = 
               Top = 6
               Left = 807
               Bottom = 114
               Right = 958
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 171
               Left = 14
               Bottom = 279
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LookupValues_1"
            Begin Extent = 
               Top = 251
               Left = 195
               Bottom = 359
               Right = 346
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_Project_Demographics';

