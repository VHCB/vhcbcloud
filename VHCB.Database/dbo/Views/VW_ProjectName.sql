CREATE VIEW dbo.VW_ProjectName
AS
SELECT     dbo.Project.ProjectId, dbo.Project.Proj_num, dbo.LookupValues.Description, dbo.AppName.Applicantname
FROM         dbo.ApplicantAppName LEFT OUTER JOIN
                      dbo.AppName ON dbo.ApplicantAppName.AppNameID = dbo.AppName.AppNameID RIGHT OUTER JOIN
                      dbo.ProjectApplicant ON dbo.ApplicantAppName.ApplicantID = dbo.ProjectApplicant.ApplicantId RIGHT OUTER JOIN
                      dbo.Address INNER JOIN
                      dbo.ProjectAddress ON dbo.Address.AddressId = dbo.ProjectAddress.AddressId RIGHT OUTER JOIN
                      dbo.Project ON dbo.ProjectAddress.ProjectId = dbo.Project.ProjectId ON dbo.ProjectApplicant.ProjectId = dbo.Project.ProjectId FULL OUTER JOIN
                      dbo.ProjectName ON dbo.Project.ProjectId = dbo.ProjectName.ProjectID FULL OUTER JOIN
                      dbo.LookupValues ON dbo.ProjectName.LkProjectname = dbo.LookupValues.TypeID
WHERE     (dbo.ProjectName.DefName = 1) AND (dbo.ApplicantAppName.DefName = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'          DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "LookupValues"
            Begin Extent = 
               Top = 2
               Left = 456
               Bottom = 110
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 1
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[16] 2[20] 3) )"
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
         Begin Table = "ApplicantAppName"
            Begin Extent = 
               Top = 160
               Left = 241
               Bottom = 268
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AppName"
            Begin Extent = 
               Top = 152
               Left = 476
               Bottom = 260
               Right = 629
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectApplicant"
            Begin Extent = 
               Top = 149
               Left = 35
               Bottom = 257
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Address"
            Begin Extent = 
               Top = 114
               Left = 667
               Bottom = 222
               Right = 820
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectAddress"
            Begin Extent = 
               Top = 1
               Left = 642
               Bottom = 109
               Right = 805
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
         Begin Table = "ProjectName"
            Begin Extent = 
               Top = 32
               Left = 248
               Bottom = 140
               Right = 399
            End
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_ProjectName';

