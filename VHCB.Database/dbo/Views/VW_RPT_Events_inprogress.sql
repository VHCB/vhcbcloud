CREATE VIEW dbo.VW_RPT_Events_inprogress
AS
SELECT     dbo.ProjectEvent.ProjectID, dbo.Project.Proj_num AS [Project Number], dbo.VWLK_ProjectNames.Description AS [Project Name], 
                      dbo.VWLK_VHCBPrograms.Description AS Program, dbo.ProjectEvent.EventID, dbo.VWLK_Event_Admin.Description AS [Admin Milestone], 
                      dbo.VWLK_Event_Admin.TypeID, dbo.ProjectEvent.Date, dbo.ProjectEvent.Note, dbo.ProjectEvent.URL, dbo.UserInfo.Username, dbo.ProjectEvent.ProgEventID, 
                      dbo.ProjectEvent.ApplicantID, dbo.VWLK_Event_SubEvent.SubDescription, dbo.VWLK_Events_All.Description
FROM         dbo.VWLK_Event_SubEvent RIGHT OUTER JOIN
                      dbo.VWLK_Events_All RIGHT OUTER JOIN
                      dbo.ProjectEvent ON dbo.VWLK_Events_All.TypeID = dbo.ProjectEvent.ProgEventID ON 
                      dbo.VWLK_Event_SubEvent.TypeID = dbo.ProjectEvent.SubEventID LEFT OUTER JOIN
                      dbo.VWLK_Event_Admin ON dbo.ProjectEvent.EventID = dbo.VWLK_Event_Admin.TypeID LEFT OUTER JOIN
                      dbo.UserInfo ON dbo.ProjectEvent.UserID = dbo.UserInfo.UserId LEFT OUTER JOIN
                      dbo.Project INNER JOIN
                      dbo.VWLK_VHCBPrograms ON dbo.Project.LkProgram = dbo.VWLK_VHCBPrograms.TypeID INNER JOIN
                      dbo.VWLK_ProjectNames ON dbo.Project.ProjectId = dbo.VWLK_ProjectNames.ProjectID AND dbo.VWLK_ProjectNames.DefName = 1 ON 
                      dbo.ProjectEvent.ProjectID = dbo.Project.ProjectId
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Events_inprogress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'071
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProjectEvent"
            Begin Extent = 
               Top = 6
               Left = 606
               Bottom = 114
               Right = 759
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
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2370
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
         Alias = 1875
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Events_inprogress';


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
            TopColumn = 0
         End
         Begin Table = "VWLK_VHCBPrograms"
            Begin Extent = 
               Top = 206
               Left = 219
               Bottom = 284
               Right = 370
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_ProjectNames"
            Begin Extent = 
               Top = 139
               Left = 417
               Bottom = 247
               Right = 569
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserInfo"
            Begin Extent = 
               Top = 193
               Left = 687
               Bottom = 301
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Event_SubEvent"
            Begin Extent = 
               Top = 105
               Left = 992
               Bottom = 225
               Right = 1143
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VWLK_Event_Admin"
            Begin Extent = 
               Top = 6
               Left = 794
               Bottom = 84
               Right = 945
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VWLK_Events_All"
            Begin Extent = 
               Top = 237
               Left = 920
               Bottom = 315
               Right = 1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_RPT_Events_inprogress';

